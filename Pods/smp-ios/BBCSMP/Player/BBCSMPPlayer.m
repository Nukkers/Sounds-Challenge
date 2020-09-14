//
//  BBCSMPPlayer.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAVDecoder.h"
#import "BBCSMPAVStatisticsConsumer.h"
#import "BBCSMPAVStatisticsManager.h"
#import "BBCSMPAirplayManager.h"
#import "BBCSMPAirplayVideoSurfaceController.h"
#import "BBCSMPAudioManager.h"
#import "BBCSMPAudioManagerObserver.h"
#import "BBCSMPBackgroundManagerNotificationAdapter.h"
#import "BBCSMPBackgroundPlaybackManager.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPDecoderFactory.h"
#import "BBCSMPDecoderLayerProvider.h"
#import "BBCSMPDefaultSettings.h"
#import "BBCSMPDisplayCoordinator.h"
#import "BBCSMPNowPlayingInfoManager.h"
#import "BBCSMPPeriodicExecutor.h"
#import "BBCSMPPeriodicExecutorFactory.h"
#import "BBCSMPPictureInPictureAvailabilityObserver.h"
#import "BBCSMPPictureInPictureController.h"
#import "BBCSMPPlayer.h"
#import "BBCSMPPlayerBitrateObserver.h"
#import "BBCSMPPlayerInitialisationContext.h"
#import "BBCSMPPlayerViewBuilder.h"
#import "BBCSMPSettingsPersistence.h"
#import "BBCSMPSettingsPersistenceNone.h"
#import "BBCSMPSubtitleManager.h"
#import "BBCSMPUIScreenAdapterFactory.h"
#import "BBCSMPVideoSurface.h"
#import "BBCSMPVolumeObserver.h"
#import "BBCSMPVolumeProvider.h"
#import "BBCSMPVideoRectObserver.h"
#import "BBCSMPSuspendRule.h"
#import "BBCSMPSuspendMechanism.h"
#import "BBCSMPTelemetryManager.h"
#import "BBCSMPPlayRequestedEvent.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"
#import "BBCSMPItemLoadedEvent.h"
#import "BBCSMPItemProviderUpdatedEvent.h"
#import "BBCSMPInternalErrorEvent.h"
#import "BBCSMPSize.h"
#import "BBCSMPDuration.h"
#import "BBCSMPTime.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPItemProvider.h"
#import "BBCSMPError.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItem.h"
#import "BBCSMPNetworkStatusProvider.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPErrorObserver.h"
#import "BBCSMPPlayerSizeObserver.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPControlCenterSubsystem.h"
#import "BBCSMPBackgroundTaskScheduler.h"
#import "BBCSMPBackgroundResourceRequestController.h"
#import "BBCSMPItemRetryRule.h"
#import "BBCSMPAutorecoveryRule.h"
#import "BBCSMPBackgroundObserver.h"
#import "BBCSMPDefaultPlayerViewFactory.h"
#import "BBCSMPPlayerViewPresenterFactory.h"
#import "BBCSMPPlayerContext.h"
#import "BBCSMPUIComposer.h"
#import "BBCSMPMediaRepository.h"
#import <SMP/SMP-Swift.h>
#import "BBCSMPUnpreparedStateListener.h"
#import "BBCSMPAttemptCDNFailoverEvent.h"
#import "BBCSMPDecoderCurrentPosition.h"
#import "BBCSMPSystemSuspension.h"

@interface BBCSMPPlayer () <BBCSMPDecoderDelegate, BBCSMPAutorecoveryDelegate, MethodsNotMigratedToFSM, BBCSMPSystemSuspensionListener>

// Behavioural
@property (nonatomic, strong) BBCSMPAVStatisticsManager *statisticsManager;
@property (nonatomic, strong) BBCSMPBackgroundPlaybackManager *backgroundManager;
@property (nonatomic, strong) BBCSMPBackgroundResourceRequestController *backgroundResourceRequestController;
@property (nonatomic, strong) BBCSMPPictureInPictureController* pipController;
@property (nonatomic, strong) BBCSMPDisplayCoordinator* displayCoordinator;
@property (nonatomic, strong) BBCSMPAirplayVideoSurfaceController* airplayScreenController;
@property (nonatomic, strong) BBCSMPTelemetryManager *telemetryManager;
@property (nonatomic, strong) BBCSMPSubtitleManager *subtitlesManager;
@property (nonatomic, strong) BBCSMPUIScreenAdapterFactory *externalDisplayProducer;
@property (nonatomic, strong) id<BBCSMPSystemSuspension> systemSuspension;
// State
@property (nonatomic, strong) id<BBCSMPItem> playerItem;
@property (nonatomic, strong) BBCSMPPlayerContext* playerContext;
@property (nonatomic, strong) BBCSMPFSM *fsm;

@property (nonatomic, strong) BBCSMPPlayerItemRequester *playerItemRequester;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, id<BBCSMPObserver>>* oldToCompatObservers;

@end

@implementation BBCSMPPlayer {
    // Behavioural
    BBCSMPAirplayManager *_airplayManager;
    BBCSMPControlCenterSubsystem *_controlCenterSubsystem;
    BOOL _isPublicPlaybackSession;
    
    id<BBCSMPUIComposer> _uiComposer;
    BBCSMPBitrate *_maximumPeakPlaybackBitrate;
}

@synthesize playerItemProvider = _playerItemProvider;

- (void)dealloc
{
    [[[self playerContext] decoder] pause];
    [self stop];
    [[[self playerContext] context].clock stop];
    [[self playerContext] context].clock = nil;
    
    [_controlCenterSubsystem teardown];
}

+ (BBCLogger *)logger
{
    static BBCLogger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BBCLoggingDomain smpDomain] loggerWithSubdomain:@"Player"];
    });
    
    return instance;
}

- (instancetype)initWithContext:(BBCSMPPlayerInitialisationContext*)context
{
    if ((self = [super init])) {
        [self commonInitFromContext:context];
    }
    return self;
}

- (void)commonInitFromContext:(BBCSMPPlayerInitialisationContext*)context
{
    __weak typeof(self) weakSelf = self;
    BBCSMPSuspendMechanism *suspendMechanism =
        [[BBCSMPSuspendMechanism alloc] initWithTimerFactory:context.timerFactory
                                                 suspendRule:context.suspendRule
                                          suspensionCallback:^{
                                              [weakSelf destroyDecoder];
                                              [weakSelf.playerItem teardown];
                                              [weakSelf.fsm suspendWithPlayer:weakSelf];
                                          }];
    self.playerItemRequester = [[BBCSMPPlayerItemRequester alloc] init];

    _fsm = [[BBCSMPFSM alloc] initWithSuspendMechanism:suspendMechanism
                            interruptionEndedBehaviour:context.interruptionEndedBehaviour
                                   playerItemRequester: self.playerItemRequester];
    [_fsm addMethodsNotMigratedToFSM:self];

    _statisticsManager = [[BBCSMPAVStatisticsManager alloc] initWithHeartbeatGenerator:context.heartbeatGenerator];
    
    _subtitlesManager = [[BBCSMPSubtitleManager alloc] initWithSettingsPersistence:context.settingsPersistence];
    [_subtitlesManager addObserver:_statisticsManager];

    self.playerContext = [[BBCSMPPlayerContext alloc] initWithPlayer:self context:context];
    [self addObserver:_statisticsManager];
    [self addObserver:_subtitlesManager];

    if ([[self playerContext] context].settingsPersistence == nil) {
        [[self playerContext] context].settingsPersistence = [BBCSMPSettingsPersistenceNone new];
    }
    [self fetchPersistentValues];

    for (id<BBCSMPObserver> observer in [context playerObservers]) {
        [self addObserver:observer];
    }

    self.playerContext.playerSize = [[BBCSMPSize alloc] init];
    [self.playerContext setTime: [BBCSMPTime relativeTime:0]];
    [[self playerContext] setEventBus:[[BBCSMPEventBus alloc] init]];

    self.pipController = [[BBCSMPPictureInPictureController alloc] init];
    [self addObserver:self.pipController];

    _displayCoordinator = [[BBCSMPDisplayCoordinator alloc] initWithPlayer:self eventBus:self.playerContext.eventBus];
    _externalDisplayProducer = context.externalDisplayProducer;
    _externalDisplayProducer.coordinator = _displayCoordinator;
    
    _airplayManager = [[BBCSMPAirplayManager alloc] initWithAirplayAvailabilityProvider:context.airplayAvailabilityProvider];
    _backgroundManager = [[BBCSMPBackgroundPlaybackManager alloc] initWithPlayer:self
                                                         backgroundStateProvider:context.backgroundStateProvider
                                                              displayCoordinator:_displayCoordinator];
    self.fsm.backgroundManager = _backgroundManager;
    [_pipController addObserver:_backgroundManager];
    

    _airplayScreenController = [[BBCSMPAirplayVideoSurfaceController alloc] initWithDisplayCoordinator:_displayCoordinator];
    [_airplayManager addObserver:_airplayScreenController];
    
    _telemetryManager = [[BBCSMPTelemetryManager alloc] initWithPlayer:self
                                                    AVMonitoringClient:[[self playerContext] context].avMonitoringService
                                                              eventBus:[[self playerContext] eventBus]
                                             sessionIdentifierProvider:[[self playerContext] context].sessionIdentifierProvider];
    
    self.playerItemProvider = context.playerItemProvider;
    
    _controlCenterSubsystem = [[BBCSMPControlCenterSubsystem alloc] initWithPlayer:self
                                                              nowPlayingInfoCenter:context.nowPlayingInfoCenter
                                                               remoteCommandCenter:context.remoteCommandCenter
                                                          backgroundStateProviding:context.backgroundStateProvider];
    
    _backgroundResourceRequestController = [[BBCSMPBackgroundResourceRequestController alloc] initWithBackgroundTimeProvider:[[self playerContext] context].backgroundTimeProvider backgroundStateProvider:context.backgroundStateProvider];
    [self addObserver:_backgroundResourceRequestController];
    [[self playerContext] setItemRetryRule:context.itemRetryRule];
    [[[self playerContext] itemRetryRule] attachToPlayerObservable:self];
    
    [[self playerContext] setAutorecoveryRule:context.autorecoveryRule];
    [[self playerContext] autorecoveryRule].delegate = self;
    [[[self playerContext] autorecoveryRule] attachToPlayerObservable:self];
    
    _isPublicPlaybackSession = YES;
    
    _uiComposer = context.uiComposer;
    _oldToCompatObservers = [[NSMutableDictionary alloc] init];
    _systemSuspension = context.systemSuspension;
    [_systemSuspension addSystemSuspensionListener:self];
}

- (id<BBCSMPSettingsPersistence>)settingsPersistence
{
    return [[self playerContext] context].settingsPersistence;
}

- (void)fetchPersistentValues
{
    [self playerContext].isMuted = [self.settingsPersistence muted];
}

- (void)setPlayerItemProvider:(id<BBCSMPItemProvider>)playerItemProvider
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"setPlayerItemProvider: %@ invoked.", playerItemProvider.description]] logLevel:BBCLogLevelDebug];

    _fsm.playerItemProvider = playerItemProvider;
    
    if (_playerItemProvider == playerItemProvider)
        return;
    
    if (_playerItemProvider != nil) {
        [[self playerContext] setItemProviderChangedSinceLastPlay:true];
    }
        
    _playerItemProvider = playerItemProvider;
    
    _statisticsManager.avStatisticsConsumer = _playerItemProvider.avStatisticsConsumer;

     [[[self playerContext] eventBus] sendEvent:[[BBCSMPItemProviderUpdatedEvent alloc] init]];
    [self loadPlayerItemMetadata];
    
 
}

- (void)loadPlayerItemMetadata
{
    __weak __typeof(self) weakSelf = self;
    [_playerItemProvider requestPreloadMetadata:^(BBCSMPItemPreloadMetadata* preloadMetadata) {
        weakSelf.playerContext.preloadMetadata = preloadMetadata;
    }
        failure:^(NSError* error) {
            BBCSMPError* wrappedError = [weakSelf errorFromError:error];
            [weakSelf.fsm loadPlayerItemMetadataFailed:wrappedError];
        }];
}

- (void)itemProviderDidLoadItem:(id<BBCSMPItem>)playerItem
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"itemProviderDidLoadItem: %@ invoked.", playerItem.description]] logLevel:BBCLogLevelDebug];

    [self setPlayerItem:playerItem];
    
    if([[self playerContext] itemProviderChangedSinceLastPlay]) {
        [[self playerContext] setItemProviderChangedSinceLastPlay:NO];
    }
    
    [self preparePlayerForCurrentPlayerItem];
}

- (void)itemProviderDidFailToLoadItemWithError:(NSError *)error
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"itemProviderDidFailToLoadItemWithError: %@ invoked.", error.description]] logLevel:BBCLogLevelDebug];

    BBCSMPError* wrappedError = [self errorFromError:error];
    [self sendInternalErrorEvent:wrappedError];
}

- (BBCSMPError*)errorFromError:(NSError*)error
{
    BBCSMPErrorEnumeration errorReason = BBCSMPErrorMediaResolutionFailed;
    const NSInteger networkParseFailureErrorCode = 3840;
    if ([error.domain isEqualToString:NSCocoaErrorDomain] && error.code == networkParseFailureErrorCode) {
        errorReason = BBCSMPErrorInitialLoadFailed;
    }

    return [BBCSMPError error:error andReason:errorReason];
}

- (void)preparePlayerForCurrentPlayerItem
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"preparePlayerForCurrentPlayerItem"] logLevel:BBCLogLevelDebug];

    [self destroyDecoder];

    if (_playerItem) {
        [self.fsm prepareToPlay];
        id<BBCSMPDecoder> decoder = [self createDecoder];
        if (decoder) {
            [self prepareForPlaybackUsingDecoder:decoder];
        }
        else {
            [self abandonPlaybackWithError:[BBCSMPError error:[NSError errorWithDomain:@"" code:0 userInfo:@{}]]];
        }
    }

}

- (id<BBCSMPDecoder>)createDecoder
{
    id<BBCSMPDecoder> decoder;
    if ([_playerItem conformsToProtocol:@protocol(BBCSMPDecoderFactory)]) {
        decoder = [((id<BBCSMPDecoderFactory>) _playerItem) createDecoder];
    } else {
        decoder = [[[self playerContext] context].decoderFactory createDecoder];
    }
    [decoder setDelegate:self];

    return decoder;
}

- (void)prepareForPlaybackUsingDecoder:(id<BBCSMPDecoder>)decoder
{
    [self playerContext].decoder = decoder;
    [self fsm].decoder = decoder;
    [self notifyPlayerItemWillAttachToPlayer];
    [[self fsm].decoder load:_playerItem.resolvedContent];
    [self notifyPlayerItemDidAttachToPlayer];

    decoder.muted = [[self playerContext] isMuted];
    [decoder setVolume:[[self playerContext] volume]];

    if (_playerItem.metadata.avType == BBCSMPAVTypeAudio) {
        [self playerLayerUpdated:nil];
        [self clearPictureInPictureController];
    }
    else {
        [self playerLayerUpdated:decoder.decoderLayer];
        [self initPictureInPictureController];
    }

    [_airplayManager setExternalPlaybackAdapter:[decoder externalPlaybackAdapter]];
}

- (void)notifyPlayerItemWillAttachToPlayer
{
    if ([_playerItem respondsToSelector:@selector(willAttachToPlayer)]) {
        [_playerItem willAttachToPlayer];
    }
}

- (void)notifyPlayerItemDidAttachToPlayer
{
    if ([_playerItem respondsToSelector:@selector(didAttachToPlayer)]) {
        [_playerItem didAttachToPlayer];
    }
}

- (void)playerLayerUpdated:(CALayer<BBCSMPDecoderLayer>*)playerLayer
{
    _displayCoordinator.layer = playerLayer;
}

- (void)initPictureInPictureController
{
    __weak typeof(self) weakSelf = self;
    [self.pipController setAdapter:[[[self fsm] decoder] pictureInPictureAdapter]];

    [[self playerContext] notifyObserversForProtocol:@protocol(BBCSMPPictureInPictureAvailabilityObserver)
                                    withBlock:^(id<BBCSMPPictureInPictureAvailabilityObserver> observer) {
                                           [observer pictureInPictureAvailabilityDidChange:weakSelf.pipController.supportsPictureInPicture];
                                    }];
}

- (void)clearPictureInPictureController
{
    [self.pipController setAdapter:nil];
}

- (void)destroyDecoder
{
    [[self fsm].decoder teardown];
    [self fsm].decoder = nil;
    [self playerLayerUpdated:nil];
    [self playerContext].decoder = nil;
}

- (void)sendInternalErrorEvent:(BBCSMPError *)error
{
    BBCSMPInternalErrorEvent *event = [[BBCSMPInternalErrorEvent alloc] init];
    event.smpError = error;
    [[self playerContext].eventBus sendEvent: event];
}

#pragma mark - BBCSMPAVDecoderDelegate methods

- (BBCSMPStateEnumeration)playerState
{
    return [self state].state;
}

- (void)decoderInterrupted
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderInterrupted invoked."] logLevel:BBCLogLevelDebug];

    [self.fsm decoderInterrupted];
}

- (void)decoderReady
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderReady invoked."] logLevel:BBCLogLevelDebug];

    [self applyPendingMaximumPeakPlaybackBitrateCap];
    [self.fsm decoderReady];
}

- (void)decoderPlaying
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderPlaying invoked."] logLevel:BBCLogLevelDebug];

    [self.fsm decoderPlaying];

    [[self playerContext] setSeekableRange:[[[self playerContext] decoder] seekableRange]];
    
    if (!_backgroundManager.isAllowedToPlay) {
        [[self fsm] pause];
    }
}

- (void)decoderPaused
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderPaused invoked."] logLevel:BBCLogLevelDebug];
    
    [self.fsm decoderPaused];
}

- (void)decoderBuffering:(BOOL)buffering
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderBuffering invoked."] logLevel:BBCLogLevelDebug];

    [self.fsm decoderBuffering:buffering];
}

- (void)decoderFailed:(BBCSMPError*)error
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderFailed invoked."] logLevel:BBCLogLevelDebug];

    BBCSMPStateEnumeration stateWhenDecoderFailed = self.state.state;
    
    [[self fsm] decoderFailed];
    
    if (stateWhenDecoderFailed == BBCSMPState.playingState.state) {
        self.fsm.autoplay = YES;
    }
    
    [self.fsm formulateStateRestorationWhenRecoveredWithPlayer:self];

    [[self playerContext] setDecoderError:error];
    [[[self playerContext] autorecoveryRule] evaluate];
}

- (void)decoderFinished
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderFinished invoked."] logLevel:BBCLogLevelDebug];
    
    [self.fsm decoderFinished];
}

- (void)decoderMuted:(BOOL)muted
{
    [[self playerContext] setIsMuted:muted];
}

- (void)decoderVolumeChanged:(float)volume
{
    [[self playerContext] setVolume:volume];
}

- (void)decoderVideoRectChanged:(CGRect)videoRect
{
    [[self playerContext] setPlayerSize:[BBCSMPSize sizeWithCGSize:videoRect.size]];
    self.playerContext.videoRect = videoRect;
}

- (void)decoderBitrateChanged:(double)bitrate
{
    [[self playerContext] notifyObserversForProtocol:@protocol(BBCSMPPlayerBitrateObserver)
                                           withBlock:^(id<BBCSMPPlayerBitrateObserver> observer) {
                                               [observer playerBitrateChanged:bitrate];
                                           }];
}

- (void)decoderPlayingPublicly
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderPlayingPublicly invoked."] logLevel:BBCLogLevelDebug];

    if (!_isPublicPlaybackSession) {
        [self pause];
    }
    
    _isPublicPlaybackSession = YES;
}

- (void)decoderPlayingPrivatley
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"decoderPlayingPrivatley invoked."] logLevel:BBCLogLevelDebug];

    _isPublicPlaybackSession = NO;
}

- (void)decoderDidProgressToPosition:(BBCSMPDecoderCurrentPosition *)currentPosition
{
    NSString *intervalString = [NSString stringWithFormat:@"decoderDidProgressToPosition invoked. %f", currentPosition.seconds];
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:intervalString] logLevel:BBCLogLevelDebug];


    [[self fsm] decoderDidProgressToPosition:currentPosition];
}

- (void)setTimeOnPlayerContext:(BBCSMPDecoderCurrentPosition *)currentPosition {
    BBCSMPTime *time;
    NSTimeInterval seconds = [currentPosition seconds];
    if (_playerItem.metadata.streamType == BBCSMPStreamTypeVOD) {
        time = [BBCSMPTime relativeTime:seconds];
    }
    else {
        time = [BBCSMPTime absoluteTimeWithIntervalSince1970:seconds];
    }
    
    [[self playerContext] setTime:time];
}

-(void)decoderEventOccurred:(NSObject<BBCDecoderEvent>*)event {
    if ([event isKindOfClass: [BBCSMPDecoderSeekTimeOutEvent class]]) {
        [_playerContext.eventBus sendEvent:[BBCSMPSeekingTimeOutEvent new]];
    }
}

#pragma mark - BBCSMPControllable implementation

- (void)prepareToPlay
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"prepareToPlay invoked."] logLevel:BBCLogLevelDebug];
    [self.fsm prepareToPlay];
}

- (void)playFromOffset:(NSTimeInterval)offsetSeconds {}

- (void)play
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"play invoked."] logLevel:BBCLogLevelDebug];
    [[self playerContext].eventBus sendEvent:[[BBCSMPPlayRequestedEvent alloc] init]];
    [self.fsm play];
}

- (void)pause
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"pause invoked."] logLevel:BBCLogLevelDebug];
    [self.fsm pause];
    self.fsm.autoplay = NO;
}

- (void)stop
{
    [self.playerItemRequester cancelPendingRequest];
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"stop invoked."] logLevel:BBCLogLevelDebug];
    [self.fsm stop];
    [self destroyDecoder];
    [self scrubToPosition:0];
    [self.playerItem teardown];
    [self playerLayerUpdated:nil];
    [self clearPictureInPictureController];
}

- (void)increasePlayRate
{
    float newRate = [[[self playerContext] decoder] increasePlayRate];
    [self notifyObserversOfPlayerRateChange:newRate];
}

- (void)decreasePlayRate
{
    float newRate = [[[self playerContext] decoder] decreasePlayRate];
    [self notifyObserversOfPlayerRateChange:newRate];
}

- (void)notifyObserversOfPlayerRateChange:(float)playerRate
{
    [[self playerContext] notifyObserversForProtocol:@protocol(BBCSMPTimeObserver)
                                           withBlock:^(id<BBCSMPTimeObserver> observer) {
                                               [observer playerRateChanged:playerRate];
                                           }];
}

- (void)scrubToPosition:(NSTimeInterval)position
{
    /*
     Discovered in MOBILE-5516
     localRefToPlayer fixes a deallocation of self, when self is deallocated (i.e. we call a listener that ends up
     deallocating the player). This is a 'feature' of Objective-C, so we need to retain self to stop the allocation
     count from reaching 0 and self being cleaned up when we're still using it. TSI response from Apple:
     
     > That would mean that when running with  ‘Optimize for Size’ that any reference to self within any instance method is
       not safe...
     
     That’s true. To rephrase, a method using self does not not implicitly retain self. The behavior you see now with the
     size optimization turned on is correct - the last reference to object A was cut, so it was immediately deallocated.
     It is likely the size optimizations removed some unnecessary retain calls along the code path, which kept the object
     alive just long enough for this not to be an issue with no optimization applied.
     
     An object graph of strong relationships is the convention that prevents this from happening normally. Calling a method
     on another object which releases the final retain on the calling object as a side effect deviates from this convention,
     so to the extent possible, I suggest trying to iron out the inverted ownership between these two objects to make it
     clear when object A can be disposed, rather than it happening as a side effect. For difficult scenarios where doing
     so isn’t feasible (and I’ve been there!), you can use the options presented previously to extend the object lifetime
     just a little bit longer.
     
     Let me know if you have additional questions,
     Ed Ford
     
     - Matt Mould & Tim Condon  11/3/2019
     */
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"scrubToInterval: %f invoked.", position]] logLevel:BBCLogLevelDebug];

    BBCSMPPlayer *localRefToPlayer __unused  = self;
    
    
    BBCSMPTime *originalTime = self.time;
    
    BBCSMPTime* newTime;
    if (self.playerContext.preloadMetadata.partialMetadata.streamType == BBCSMPStreamTypeVOD) {
        newTime = [BBCSMPTime relativeTime:position];
    } else {
        newTime = [BBCSMPTime absoluteTimeWithIntervalSince1970:position];
    }

    [self playerContext].time = newTime;

    [[self playerContext] notifyObserversForProtocol:@protocol(BBCSMPTimeObserver) withBlock:^(id<BBCSMPTimeObserver>observer) {
        [observer scrubbedFromTime:originalTime toTime:newTime];
    }];


    [[self fsm] seekTo:position on:self];

    localRefToPlayer = nil;
}

- (void)activateSubtitles
{
    [_subtitlesManager activateSubtitles];
}

- (void)deactivateSubtitles
{
    [_subtitlesManager deactivateSubtitles];
}

- (void)mute
{
    [[self playerContext] setIsMuted:YES];
    [[self fsm] decoder].muted = YES;
}

- (void)unmute
{
    [[self playerContext] setIsMuted:NO];
    [[self fsm] decoder].muted = NO;
}

- (void)changeVolume:(float)volume
{
    [[self playerContext] setVolume:volume];
    [[[self fsm] decoder] setVolume:volume];
}

- (void)transitionToPictureInPicture
{
    [_pipController startPictureInPicture];
}

- (void)exitPictureInPicture
{
    [_pipController stopPictureInPictureWithCompletionHandler:nil];
}

- (void)limitMaximumPeakPlaybackBitrateToBitrate:(BBCSMPBitrate *)maximumPeakPlaybackBitrate
{
    _maximumPeakPlaybackBitrate = maximumPeakPlaybackBitrate;
    
    if (maximumPeakPlaybackBitrate) {
        [self limitDecoderPlaybackToMaximumPreferredBitrate:maximumPeakPlaybackBitrate];
    }
}

- (void)removeMaximumPeakPlaybackBitrateLimit
{
    _maximumPeakPlaybackBitrate = nil;
    [[[self playerContext] decoder] removePeakBitrateRestrictions];
}

- (void)limitDecoderPlaybackToMaximumPreferredBitrate:(BBCSMPBitrate *)bitrate
{
    [[[self playerContext] decoder] restrictPeakBitrateToBitsPerSecond:bitrate.bitsPerSecond];
}

#pragma mark - BBCSMPUI

- (void)registerVideoSurface:(id<BBCSMPVideoSurface>)videoSurface
{
    [_displayCoordinator attachVideoSurface:videoSurface];
}

- (void)deregisterVideoSurface:(id<BBCSMPVideoSurface>)videoSurface
{
    [_displayCoordinator detachVideoSurface:videoSurface];
}

- (id<BBCSMPUIBuilder>)buildUserInterface
{
    return [_uiComposer createBuilderWithPlayer:self videoSurfaceManager:self];
}

- (void)setContentFit
{
    [[[self playerContext] decoder] setContentFit];
}

- (void)setContentFill
{
    [[[self playerContext] decoder] setContentFill];
}

#pragma mark - Observer management

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [[self playerContext] addObserver:observer];
    [[self fsm] addObserver:observer player:self seekableRange:_playerContext.seekableRange];
    
    if ([observer conformsToProtocol:@protocol(BBCSMPSubtitleObserver)]) {
        [_subtitlesManager addObserver:observer];
    }
    if ([observer conformsToProtocol:@protocol(BBCSMPAirplayObserver)]) {
        [_airplayManager addObserver:(id<BBCSMPAirplayObserver>)observer];
    }
    if ([observer conformsToProtocol:@protocol(BBCSMPPictureInPictureControllerObserver)]) {
        [_pipController addObserver:(id<BBCSMPPictureInPictureControllerObserver>)observer];
    }

    if ([observer conformsToProtocol:@protocol(BBCSMPAudioManagerObserver)]) {
        [[[self playerContext] context].audioManager addObserver:(id<BBCSMPAudioManagerObserver>)observer];
    }

    [self notifyObserver:observer];
}

- (void)removeObserver:(id)observer
{
    [[self playerContext] removeObserver:observer];
    [[self fsm] removeObserver:observer];

    if ([observer conformsToProtocol:@protocol(BBCSMPSubtitleObserver)]) {
        [_subtitlesManager removeObserver:observer];
    }
    if ([observer conformsToProtocol:@protocol(BBCSMPAirplayObserver)]) {
        [_airplayManager removeObserver:observer];
    }
    if ([observer conformsToProtocol:@protocol(BBCSMPPictureInPictureControllerObserver)]) {
        [_pipController removeObserver:(id<BBCSMPPictureInPictureControllerObserver>)observer];
    }
    if ([observer conformsToProtocol:@protocol(BBCSMPAudioManagerObserver)]) {
        [[[self playerContext] context].audioManager removeObserver:(id<BBCSMPAudioManagerObserver>)observer];
    }
}

- (void)addStateObserver:(nonnull id<BBCSMPPlaybackStateObserver>)observer {
    BBCSMPPlaybackStateObserverCompat *compatObserver = [[BBCSMPPlaybackStateObserverCompat alloc] initWithObserver:observer];
    NSNumber *key = [NSNumber numberWithLong:[observer hash]];
    [self.oldToCompatObservers setObject:compatObserver forKey:key];
    [self addObserver:compatObserver];
}


- (void)removeStateObserver:(nonnull id<BBCSMPPlaybackStateObserver>)observer {
    NSNumber *key = [NSNumber numberWithLong:[observer hash]];

    [self removeObserver:self.oldToCompatObservers[key]];
    [self.oldToCompatObservers removeObjectForKey:key];
}


- (void)notifyObserver:(id<BBCSMPObserver>)observer
{
    if ([observer conformsToProtocol:@protocol(BBCSMPItemObserver)]) {
        if (_playerItem) {
            [(id<BBCSMPItemObserver>)observer itemUpdated:_playerItem];
        }
    }

    if ([observer conformsToProtocol:@protocol(BBCSMPPreloadMetadataObserver)]) {
        [(id<BBCSMPPreloadMetadataObserver>)observer preloadMetadataUpdated:[[self playerContext] preloadMetadata]];
    }

    if ([observer conformsToProtocol:@protocol(BBCSMPErrorObserver)]) {
        [_fsm notifyErrorObserver:(id<BBCSMPErrorObserver>)observer];
    }

    if ([observer conformsToProtocol:@protocol(BBCSMPVolumeObserver)]) {
        [(id<BBCSMPVolumeObserver>)observer playerMuteStateChanged:@([[self playerContext] isMuted])];
        [(id<BBCSMPVolumeObserver>)observer playerVolumeChanged:@([[self playerContext] volume])];
    }

    if([observer conformsToProtocol:@protocol(BBCSMPPictureInPictureAvailabilityObserver)]) {
        [(id<BBCSMPPictureInPictureAvailabilityObserver>)observer pictureInPictureAvailabilityDidChange:_pipController.supportsPictureInPicture];
    }

    if([observer conformsToProtocol:@protocol(BBCSMPVideoRectObserver)]) {
        [(id<BBCSMPVideoRectObserver>)observer player:self videoRectDidChange:[self videoRect]];
    }
}

#pragma mark - Player updates that trigger notifications to observer

- (void)setPlayerItem:(id<BBCSMPItem>)playerItem
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"setPlayerItem: %@ invoked.", playerItem.description]] logLevel:BBCLogLevelDebug];
    if ([_playerItem isEqual:playerItem])
        return;

    _playerItem = playerItem;
    [[self playerContext].eventBus sendEvent:[[BBCSMPItemLoadedEvent alloc] initWithItem:playerItem]];
    [[self playerContext] notifyObserversForProtocol:@protocol(BBCSMPItemObserver)
                                           withBlock:^(id<BBCSMPItemObserver> observer) {
                                               [observer itemUpdated:playerItem];
                                       }];

    [self playerContext].preloadMetadata = [playerItem metadata].preloadMetadata;
}

#pragma mark - Error handler delegate methods

- (void)requestFailoverItem:(BBCSMPError *)error player:(BBCSMPPlayer *const __weak)player {
    [self.playerItemRequester requestFailoverItemWithItemProvider:self.playerItemProvider
                                                          success:^(id<BBCSMPItem> playerItem){
                                                              error.recovered = YES;

                                                              player.playerItem = playerItem;

                                                              [player.fsm itemLoadedWithItem:playerItem];
                                                              [player prepareToPlay];
                                                          }
                                                          failure:^(NSError* failoverError){
        [player abandonPlaybackWithError:[BBCSMPError error:failoverError]];

    }];
}

- (void)attemptFailoverFromError:(BBCSMPError*)error
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"attemptFailoverFromError: %@ invoked.", error.description]] logLevel:BBCLogLevelDebug];

    __weak typeof(self) weakSelf = self;
    [[self playerContext].eventBus sendEvent:[[BBCSMPAttemptCDNFailoverEvent alloc] init]];

    [self requestFailoverItem:error player:weakSelf];
}

- (void)retryCurrentItem
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"retryCurrentItem invoked"] logLevel:BBCLogLevelDebug];

    [[[self playerContext] decoder] teardown];
    id<BBCSMPDecoder> newDecoder = [[[self playerContext] context].decoderFactory createDecoder];
    [self playerContext].decoder = newDecoder;
    [self fsm].decoder = newDecoder;
    [[self playerContext] decoder].delegate = self;
    [[[self playerContext] decoder] load:_playerItem.resolvedContent];
    [self.fsm prepareToPlay];
    self.fsm.autoplay = YES;
}

- (void)abandonPlaybackWithError:(BBCSMPError*)error
{
    [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"abandonPlaybackWithError: %@ invoked.", error.description]] logLevel:BBCLogLevelDebug];

    BBCSMPError *internalError = [BBCSMPError error:[NSError errorWithDomain:@"smp-ios" code:1000 userInfo:nil]];
    [self sendInternalErrorEvent:internalError];
    [self.fsm error: error];
    [[[self playerContext] decoder] pause];
    [self destroyDecoder];
}

- (void)clockDidTickToTime:(BBCSMPClockTime*) clockTime {
    [_telemetryManager clockDidTickToTime: clockTime];
}

#pragma mark BBCSMPAutorecoveryDelegate

- (void)autorecoveryShouldBePerformed
{
    if ([[self playerContext] decoderError].recoverable && [[[self playerContext] itemRetryRule] evaluateRule]) {
        [[BBCSMPPlayer logger] logMessage:[BBCStringLogMessage messageWithMessage:@"Retrying current item"]];
        [self retryCurrentItem];
    }
    else {
        [_playerItem teardown];
        [_fsm attemptFailoverFromError:[[self playerContext] decoderError]];
        [self attemptFailoverFromError:[[self playerContext] decoderError]];
    }
}

- (void)autorecoveryShouldAbandonPlayback
{
    [self abandonPlaybackWithError:[[self playerContext] decoderError]];
}

#pragma mark -

-(BBCSMPSize*)playerSize
{
    return [[self playerContext] playerSize];
}

-(BBCSMPDuration*)duration
{
    return [[self fsm] duration];
}

-(BBCSMPTime*)time
{
    return [[self playerContext] time];
}

-(CGRect)videoRect
{
    return [[self playerContext] videoRect];
}

// TODO - why does removing this cause tests to fail
// This shouldn't be the case
-(BBCSMPPlayerInitialisationContext *)context
{
    return [[self playerContext] context];
}

-(BBCSMPState *)state
{
    return [[self fsm] publicState];
}

#pragma mark Internal Protocol Requirements

- (void)addUnpreparedStateListener:(id<BBCSMPUnpreparedStateListener>)unpreparedStateListener
{
    
}

-(void)setDisplayCoordinator:(BBCSMPDisplayCoordinator *)displayCoordinator {
    _externalDisplayProducer.coordinator = displayCoordinator;
}

- (void)applyPendingMaximumPeakPlaybackBitrateCap
{
    if (_maximumPeakPlaybackBitrate) {
        [self limitMaximumPeakPlaybackBitrateToBitrate:_maximumPeakPlaybackBitrate];
    }
    else {
        [[[self playerContext] decoder] removePeakBitrateRestrictions];
    }
}

- (void)systemSuspended {
    [self pause];
}

@end
