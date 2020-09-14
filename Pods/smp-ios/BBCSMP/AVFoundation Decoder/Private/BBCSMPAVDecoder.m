//
//  BBCSMPAVDecoder.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "AVAudioSessionProtocol.h"
#import "AVPlayerProtocol.h"
#import "BBCSMPAVComponentFactory.h"
#import "BBCSMPAVDecoder.h"
#import "BBCSMPAVDecoderAudioAdapter.h"
#import "BBCSMPAVObservationCenter.h"
#import "BBCSMPAVDecoderTimeAdapter.h"
#import "BBCSMPAVExternalPlaybackAdapter.h"
#import "BBCSMPAVPlayerLayerFactory.h"
#import "BBCSMPAVPictureInPictureAdapter.h"
#import "BBCSMPAVPictureInPictureAdapterFactory.h"
#import "BBCSMPAVSeekController.h"
#import "BBCSMPAVSeekableRangeCache.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPDecoderLayer.h"
#import "BBCSMPNetworkStatusManager.h"
#import "BBCSMPURLResolvedContent.h"
#import "BBCSMPWorker.h"
#import "BBCSMPError.h"
#import "BBCSMPAVBufferingController.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVCriticalErrorEvent.h"
#import "BBCSMPAVPlayerItemFactory.h"
#import "BBCSMPAVItemStatusController.h"
#import "BBCSMPAVErrorController.h"
#import "BBCSMPAVLoadingStallDetector.h"
#import <AVFoundation/AVFoundation.h>
#import "BBCSMPAVInterruptionController.h"
#import "BBCSMPAVRateChangedEvent.h"
#import "BBCSMPAudioRouter.h"
#import "BBCSMPDecoderCurrentPosition.h"
#import <SMP/SMP-Swift.h>

@interface AVPlayerLayer (BBCSMPAVDecoderLayerCompatibility) <BBCSMPDecoderLayer>
@end

#pragma mark -

@interface BBCSMPAVDecoder () <BBCSMPConnectivityObserver, BBCSMPAudioRouterObserver>
@end

@implementation BBCSMPAVDecoder {
    BBCSMPEventBus *_eventBus;
    id<BBCSMPConnectivity> _connectivity;
    id<BBCSMPAVPlayerLayerFactory> _layerFactory;
    id<AVPlayerProtocol> _avPlayerProtocol;
    id<BBCSMPAVPlayerItemFactory> _playerItemFactory;
    BOOL _isStream;
    BOOL _itemNeedsReplacing;
    BOOL _isHandlingPause;
    AVPlayerItem *_currentItem;
    AVPlayerLayer* _playerLayer;
    BBCSMPAVExternalPlaybackAdapter* _externalPlaybackAdapter;
    BBCSMPAVSeekController* _seekController;
    BBCSMPAVDecoderAudioAdapter* _decoderAudioAdapter;
    BBCSMPAVDecoderTimeAdapter* _timeAdapter;
    BBCSMPAVObservationCenter* _observationCenter;
    BBCSMPAVBufferingController* _bufferingController;
    BBCSMPAVItemStatusController* _playbackStatusController;
    BBCSMPAVErrorController *_criticalErrorController;
    BBCSMPAVSeekableRangeCache *_seekableRangeCache;
    BBCSMPAVPlayheadMovedController *_playheadChangedController;
    BBCSMPAVLoadingStallDetector *_loadingStallDetector;
    BBCSMPAVInterruptionController *_audioSessionInterruptionAdapter;
    NSString *_currentAudioRouteName;
}

@synthesize delegate = _delegate;

- (instancetype)initWithPlayer:(id<AVPlayerProtocol>)player
              componentFactory:(id<BBCSMPAVComponentFactory>)componentFactory
                  layerFactory:(id<BBCSMPAVPlayerLayerFactory>)layerFactory
                  connectivity:(nullable id<BBCSMPConnectivity>)connectivity
                callbackWorker:(id<BBCSMPWorker>)callbackWorker
               updateFrequency:(CMTime)updateFrequency
                  timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
              bufferingIntervalUntilStall:(NSTimeInterval)bufferingIntervalUntilStall
             playerItemFactory:(id<BBCSMPAVPlayerItemFactory>)playerItemFactory
                   audioRouter:(id<BBCSMPAudioRouter>)audioRouter
                 seekTolerance:(NSTimeInterval)seekTolerance
           seekCompleteTimeout: (NSTimeInterval)seekCompleteTimeout
{
    self = [super init];
    if (self) {
        _eventBus = [[BBCSMPEventBus alloc] init];
        _avPlayerProtocol = player;
        _layerFactory = layerFactory;
        _connectivity = connectivity;
        _playerItemFactory = playerItemFactory;
        _playerLayer = [_layerFactory playerLayerWithPlayer:_avPlayerProtocol];
        [_connectivity addConnectivityObserver:self];

        _criticalErrorController = [[BBCSMPAVErrorController alloc] initWithEventBus:_eventBus];
        _seekableRangeCache = [[BBCSMPAVSeekableRangeCache alloc] initWithEventBus:_eventBus];
        _externalPlaybackAdapter = [[BBCSMPAVExternalPlaybackAdapter alloc] initWithEventBus:_eventBus player:_avPlayerProtocol];
        _decoderAudioAdapter = [[BBCSMPAVDecoderAudioAdapter alloc] initWithComponentFactory:componentFactory];
        _playbackStatusController = [[BBCSMPAVItemStatusController alloc] initWithEventBus:_eventBus player:_avPlayerProtocol];
        _playheadChangedController = [[BBCSMPAVPlayheadMovedController alloc] initWithEventBus:_eventBus player:player seekTolerance: seekTolerance timerFactory:timerFactory seekCompleteTimeout: seekCompleteTimeout];
        _loadingStallDetector = [[BBCSMPAVLoadingStallDetector alloc] initWithEventBus:_eventBus
                                                                          timerFactory:timerFactory
                                                           bufferingIntervalUntilStall:bufferingIntervalUntilStall];
        
        _bufferingController = [[BBCSMPAVBufferingController alloc] initWithEventBus:_eventBus
                                                                          timerFactory:timerFactory
                                                           bufferingIntervalUntilStall:bufferingIntervalUntilStall];
        
        _observationCenter = [[BBCSMPAVObservationCenter alloc] initWithEventBus:_eventBus
                                                                                 player:player
                                                                            playerLayer:_playerLayer
                                                                        updateFrequency:updateFrequency
                                                                externalPlaybackAdapter:_externalPlaybackAdapter
                                                                     seekableRangeCache:_seekableRangeCache
                                                                         callbackWorker:callbackWorker];
        
        _seekController = [[BBCSMPAVSeekController alloc] initWithDecoder:self
                                                                       eventBus:_eventBus
                                                                         player:_avPlayerProtocol
                                                             seekableRangeCache:_seekableRangeCache
                                                playheadChangedController: _playheadChangedController];
        
        _timeAdapter = [[BBCSMPAVDecoderTimeAdapter alloc] initWithEventBus:_eventBus
                                                             seekController:_seekController];
        
        _audioSessionInterruptionAdapter = [[BBCSMPAVInterruptionController alloc] initWithEventBus:_eventBus];
        
        [_eventBus addTarget:self selector:@selector(playerRateChanged:) forEventType:[BBCSMPAVRateChangedEvent class]];
        
        [audioRouter addAudioRouterObserver:self];
    }

    return self;
}

+ (BBCLogger *)logger
{
    static BBCLogger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BBCLoggingDomain smpDomain] loggerWithSubdomain:@"BBCSMPAVDecoder"];
    });
    
    return instance;
}

- (void)playerRateChanged:(BBCSMPAVRateChangedEvent *)event
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"playerRateChanged: %f", event.rate]] logLevel:BBCLogLevelDebug];

    if ([self interruptionDetectedFromRateDidChangeEvent:event]) {
        [_delegate decoderInterrupted];
    }
    
    if (event.rate > 0) {
        _isHandlingPause = NO;
    }
}

- (BOOL)interruptionDetectedFromRateDidChangeEvent:(BBCSMPAVRateChangedEvent *)event
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"interruptionDetectedFromRateDidChangeEvent: %f", event.rate]] logLevel:BBCLogLevelDebug];

    return event.rate == 0 && [_delegate playerState] == BBCSMPStatePlaying && !_isHandlingPause;
}

#pragma mark BBCSMPAVDecoder

- (void)setDelegate:(id<BBCSMPDecoderDelegate>)delegate
{
    _delegate = [[BBCSMPDisableableAVDecoderDelegate alloc] initWithDecoderDelegate:delegate];
    
    
    [self sendDecoderDelegateDidChangeEvent];
    [self tellDelegateAboutCurrentAudioPrivacy];
}

- (CALayer<BBCSMPDecoderLayer>*)decoderLayer
{
    return _playerLayer;
}

- (BOOL)isMuted
{
    return _avPlayerProtocol.muted;
}

- (void)setMuted:(BOOL)muted
{
    _avPlayerProtocol.muted = muted;
}

- (float)volume
{
    return _avPlayerProtocol.volume;
}

- (void)setVolume:(float)volume
{
    _avPlayerProtocol.volume = volume;
}

- (void)restrictPeakBitrateToBitsPerSecond:(double)preferredPeakBitRate
{
    _currentItem.preferredPeakBitRate = preferredPeakBitRate;
}

- (BBCSMPDuration*)duration
{
    return _timeAdapter.duration;
}

- (BBCSMPTimeRange*)seekableRange
{
    return [_seekController seekableTimeRange];
}

- (id<BBCSMPPictureInPictureAdapter>)pictureInPictureAdapter
{
    return [BBCSMPAVPictureInPictureAdapterFactory createPictureInPictureAdapterWithPlayerLayer:_playerLayer];
}

- (id<BBCSMPExternalPlaybackAdapter>)externalPlaybackAdapter
{
    return _externalPlaybackAdapter;
}

- (void)play
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"play invoked. %@",self]] logLevel:BBCLogLevelDebug];
    [_decoderAudioAdapter prepareSessionForPlayback];

    BOOL isReachable = [_connectivity isReachable];

    if (!isReachable && !_currentItem.playbackLikelyToKeepUp && _isStream) {
        [_eventBus sendEvent:[BBCSMPAVCriticalErrorEvent event]];
    }
    else {
        [_seekController prepareToPlay];
        [_avPlayerProtocol play];
        [_bufferingController playbackRequested];
    }
}

- (void)pause
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"pause invoked. %@",self]] logLevel:BBCLogLevelDebug];

    _isHandlingPause = YES;
    [_avPlayerProtocol pause];
    [_loadingStallDetector pause];
    [_bufferingController pause];
}

- (float)increasePlayRate
{
    float currentRate = [_avPlayerProtocol rate];
    float newPlayerRate = 0.0;

    if (currentRate == 0) {
        newPlayerRate = 2.0;
    }
    else if (currentRate < 0) {
        newPlayerRate = currentRate / 2;
        if (newPlayerRate == -0.5) {
            newPlayerRate = 1.0;
        }
    }
    else {
        newPlayerRate = 2 * currentRate;
        if (newPlayerRate > 128.0) {
            newPlayerRate = currentRate;
        }
    }

    [_avPlayerProtocol setRate:newPlayerRate];
    return newPlayerRate;
}

- (float)decreasePlayRate
{
    float currentRate = [_avPlayerProtocol rate];
    float newPlayerRate = 0.0;

    if (currentRate == 0.0) {
        newPlayerRate = -1.0;
    }
    else if (currentRate == 1.0) {
        newPlayerRate = -1.0;
    }
    else if (currentRate > 0) {
        newPlayerRate = currentRate / 2;
    }
    else {
        newPlayerRate = currentRate * 2;
        if (newPlayerRate < -128.0) {
            newPlayerRate = currentRate;
        }
    }
    [_avPlayerProtocol setRate:newPlayerRate];
    return newPlayerRate;
}

- (void)teardown
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"teardown invoked. %@",self]] logLevel:BBCLogLevelDebug];
    _externalPlaybackAdapter = nil;
    [_connectivity removeConnectivityObserver:self];
    [_avPlayerProtocol replaceCurrentItemWithPlayerItem:nil];
    [_avPlayerProtocol pause];
    [self setDelegate:nil];
}



- (void)load:(id<BBCSMPResolvedContent>)resolvedContent
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"load: %@ invoked. with %@", resolvedContent, self]] logLevel:BBCLogLevelDebug];

    _isStream = resolvedContent.isNetworkResource;
    _observationCenter.streaming = _isStream;

    _currentItem = [_playerItemFactory createPlayerItemWithURL:resolvedContent.content];
    if ([self shouldWaitForNetworkAvailability]) {
        _itemNeedsReplacing = YES;
    }
    else {
        [self loadCurrentItem];
    }
}

- (void)loadCurrentItem
{
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"load current item. with %@", self]] logLevel:BBCLogLevelDebug];
    
    BBCSMPAVPlayerItemChangedEvent *event = [[BBCSMPAVPlayerItemChangedEvent alloc] initWithPlayerItem:_currentItem];
    [_eventBus sendEvent:event];
    [_avPlayerProtocol replaceCurrentItemWithPlayerItem:_currentItem];
}

- (void)scrubToAbsoluteTimeInterval:(NSTimeInterval)absoluteTimeInterval
{
    
    [[BBCSMPAVDecoder logger] logMessage:[BBCStringLogMessage messageWithMessage:[NSString stringWithFormat:@"scrubToAbsoluteTimeInterval: %f invoked.", absoluteTimeInterval]] logLevel:BBCLogLevelDebug];

    [_seekController scrubToAbsoluteTimeInterval:absoluteTimeInterval];
}

- (void)setContentFit
{
    self.decoderLayer.videoGravity = AVLayerVideoGravityResizeAspect;
}

- (void)setContentFill
{
    self.decoderLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (void)removePeakBitrateRestrictions
{
    [self restrictPeakBitrateToBitsPerSecond:0];
}

#pragma mark BBCSMPConnectivityObserver

- (void)connectivityChanged:(BOOL)isConnected
{
    if (isConnected && _itemNeedsReplacing) {
        [self loadCurrentItem];
        _itemNeedsReplacing = NO;
    }
}

#pragma mark Private

- (BOOL)shouldWaitForNetworkAvailability
{
    return _isStream && _connectivity && !_connectivity.isReachable;
}

- (void)audioOutputDidChangeToRouteNamed:(NSString *)routeName
{
    _currentAudioRouteName = routeName;
    [self tellDelegateAboutCurrentAudioPrivacy];
}

- (BOOL)isPlayingAudioUsingBuiltInSpeaker
{
    return [_currentAudioRouteName isEqualToString:AVAudioSessionPortBuiltInSpeaker];
}

- (void)tellDelegateAboutCurrentAudioPrivacy
{
    if ([self isPlayingAudioUsingBuiltInSpeaker]) {
        [_delegate decoderPlayingPublicly];
    }
    else {
        [_delegate decoderPlayingPrivatley];
    }
}

- (void)sendDecoderDelegateDidChangeEvent
{
    BBCSMPAVDecoderDelegateDidChangeEvent *event = [[BBCSMPAVDecoderDelegateDidChangeEvent alloc] initWithDecoderDelegate:_delegate];
    [_eventBus sendEvent:event];
}

@end
