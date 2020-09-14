//
//  BBCSMPStatisticsManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPNetworkStatus.h>
#import "BBCSMPAVStatisticsConsumer.h"
#import "BBCSMPAVStatisticsManager.h"
#import "BBCSMPElapsedPlaybackHeartbeat.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPUserInteractionStatisticsConsumer.h"
#import "BBCSMPSize.h"
#import "BBCSMPTime.h"
#import "BBCSMPItem.h"
#import "BBCSMPDuration.h"
#import "BBCSMPError.h"
#import "BBCSMPNetworkStatus.h"
#import "BBCSMPAVStatisticsConsumer.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPItemPreloadMetadata.h"

@interface BBCSMPItemStatisticsContext : NSObject

@property (nonatomic, strong, readonly) id<BBCSMPItem> currentItem;
@property (nonatomic, strong) BBCSMPState* currentState;
@property (nonatomic, strong) BBCSMPDuration* currentDuration;
@property (nonatomic, strong) BBCSMPTime* currentTime;
@property (nonatomic, strong) BBCSMPError* currentError;

- (instancetype)initWithItem:(id<BBCSMPItem>)item;

@end

@implementation BBCSMPItemStatisticsContext

- (instancetype)initWithItem:(id<BBCSMPItem>)item
{
    if ((self = [super init])) {
        _currentItem = item;
        _currentState = [BBCSMPState idleState];
    }
    return self;
}

@end

@interface BBCSMPAVStatisticsManager () <BBCSMPAVStatisticsHeartbeatGeneratorDelegate>

@property (nonatomic, strong) BBCSMPObserverManager* observerManager;
@property (nonatomic, strong) id<BBCSMPAVStatisticsHeartbeatGenerator> heartbeatGenerator;
@property (nonatomic, strong) BBCSMPItemStatisticsContext* currentItemContext;
@property (nonatomic, readonly) BOOL isLive;
@property (nonatomic, assign) BOOL subtitlesActive;
@property (nonatomic, strong) BBCSMPSize* playerSize;
@property (nonatomic, strong) BBCSMPNetworkStatus* currentNetworkStatus;
@property (nonatomic, assign) BOOL isSeeking;
@property (nonatomic, assign) BBCSMPItemPreloadMetadata* preloadMetadata;
@property (nonatomic, strong) BBCSMPTimeRange* timeRange;

@end

@implementation BBCSMPAVStatisticsManager

- (instancetype)initWithHeartbeatGenerator:(id<BBCSMPAVStatisticsHeartbeatGenerator>)heartbeatGenerator
{
    if ((self = [super init])) {
        _heartbeatGenerator = heartbeatGenerator;
        [_heartbeatGenerator setDelegate:self];
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _playerSize = [[BBCSMPSize alloc] init];
    _observerManager = [[BBCSMPObserverManager alloc] init];
    _observerManager.retainsObservers = YES;
    _currentNetworkStatus = [[BBCSMPNetworkStatusManager sharedManager] status];
    [[BBCSMPNetworkStatusManager sharedManager] addObserver:self];
}

- (void)setAvStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>)consumer
{
    NSAssert([consumer conformsToProtocol:@protocol(BBCSMPAVStatisticsConsumer)], @"Consumer does not conform to BBCSMPAVStatisticsConsumer protocol");
    _avStatisticsConsumer = consumer;
}

- (void)removeStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>)consumer
{
    [_observerManager removeObserver:consumer];
}

- (BOOL)isLive
{
    return self.currentItemContext.currentTime.type == BBCSMPTimeAbsolute;
}

#pragma mark - Item observer

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    self.currentItemContext = playerItem ? [[BBCSMPItemStatisticsContext alloc] initWithItem:playerItem] : nil;
}

#pragma - State observer

- (void)stateChanged:(BBCSMPState*)state
{
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           if ([avConsumer respondsToSelector:@selector(stateChanged:)]) {
                                               [avConsumer stateChanged:state];
                                           }
                                       }];
    [_heartbeatGenerator stateChanged:state];

    __weak typeof(self) weakSelf = self;
    switch (state.state) {
    case BBCSMPStatePlaying: {
        self.isSeeking = NO;

        switch (self.currentItemContext.currentState.state) {
        case BBCSMPStatePaused: {
            [self.observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                                   withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                                       [avConsumer trackAVResumeForPlaylistTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                                      assetTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                                currentLocation:weakSelf.isLive ? 0 : weakSelf.currentItemContext.currentTime.seconds];
                                                   }];
            break;
        }
        case BBCSMPStateBuffering:
        case BBCSMPStateIdle:
        case BBCSMPStateLoadingItem:
        case BBCSMPStateItemLoaded:
        case BBCSMPStatePreparingToPlay:
        case BBCSMPStatePlayerReady:
        case BBCSMPStateEnded: {
            [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                               withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                                   [weakSelf trackAVPlaybackOnConsumer:avConsumer];
                                               }];
            break;
        }
        case BBCSMPStatePlaying:
        default: {
            break;
        }
        }
        break;
    }
    case BBCSMPStateBuffering: {
        if(!_isSeeking) {
        [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                           withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                               [avConsumer trackAVBufferForPlaylistTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                              assetTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                        currentLocation:weakSelf.isLive ? 0 : weakSelf.currentItemContext.currentTime.seconds];
                                           }];
        }
        break;
    }
    case BBCSMPStatePaused: {
        [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                           withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                               [avConsumer trackAVPauseForPlaylistTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                             assetTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                       currentLocation:weakSelf.isLive ? 0 : weakSelf.currentItemContext.currentTime.seconds];
                                           }];
        break;
    }
    case BBCSMPStateEnded:
    case BBCSMPStateStopping: {
        __weak typeof(_observerManager) weakObserverManager = _observerManager;
        [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                           withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                               [avConsumer trackAVEndForSubtitlesActive:weakSelf.subtitlesActive
                                                                           playlistTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                              assetTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                          assetDuration:weakSelf.isLive ? 0 : weakSelf.currentItemContext.currentDuration.seconds
                                                                             wasNatural:weakSelf.currentItemContext.currentError == nil
                                                                   withCustomParameters:nil];
                                               [weakObserverManager removeObserver:self.avStatisticsConsumer];
                                           }];
        break;
    }
    case BBCSMPStateIdle:
        break;
    case BBCSMPStateLoadingItem: {
        if (self.avStatisticsConsumer) {
            [_observerManager addObserver:self.avStatisticsConsumer];
        }
        [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                           withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                               if ([avConsumer respondsToSelector:@selector(customAvStatsLabelsChanged:)]) {
                                                   [avConsumer customAvStatsLabelsChanged:self.preloadMetadata.customAvStatsLabels];
                                               }
                                           }];
        [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                           withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                               BBCSMPItemMetadata* itemMetaData = [[BBCSMPItemMetadata alloc] initWithPreloadMetadata:self.preloadMetadata];
                                               [avConsumer trackAVSessionStartForItemMetadata:itemMetaData];
                                           }];
        break;
    }
    case BBCSMPStateItemLoaded:
    case BBCSMPStatePreparingToPlay:
    case BBCSMPStatePlayerReady:
    default: {
        break;
    }
    }
    self.currentItemContext.currentState = state;
}

#pragma - Time observer

- (void)durationChanged:(BBCSMPDuration*)duration
{
    self.currentItemContext.currentDuration = duration;
    if (self.currentItemContext.currentDuration) {
        [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                           withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                               [avConsumer trackAVFullMediaLength:duration.seconds];
                                           }];
    }
}

- (void)timeChanged:(BBCSMPTime*)time
{
    self.currentItemContext.currentTime = time;
    [_heartbeatGenerator update];
    
    if (self.isSeeking) {
        self.isSeeking = NO;
        if (self.currentItemContext.currentState.state == BBCSMPStatePlaying) {
            __weak __typeof(self) weakSelf = self;
            [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                               withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                                   [weakSelf trackAVPlaybackOnConsumer:avConsumer];
                                               }];
            
        }
    }
    
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           if ([avConsumer respondsToSelector:@selector(timeChanged:)]) {
                                               [avConsumer timeChanged:time];
                                           }
                                       }];
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    self.timeRange = range;
    
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           if ([avConsumer respondsToSelector:@selector(seekableRangeChanged:)]) {
                                               [avConsumer seekableRangeChanged:range];
                                           }
                                       }];
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime
{
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           [avConsumer trackAVScrubFromTime:fromTime.seconds toTime:toTime.seconds];
                                           weakSelf.isSeeking = YES;
                                       }];
}

- (void)playerRateChanged:(float)newPlayerRate
{
}

- (void)trackAVPlaybackOnConsumer:(id<BBCSMPAVStatisticsConsumer>)avConsumer
{
    NSDictionary* customParameters = nil;
    if (self.currentItemContext.currentItem.metadata.supplier.length > 0) {
        customParameters = @{ @"xc" : [self.currentItemContext.currentItem.metadata.supplier stringByReplacingOccurrencesOfString:@" " withString:@"_"] };
    }
    [avConsumer trackAVPlaybackWithCurrentLocation:self.isLive ? 0 : self.currentItemContext.currentTime.seconds customParameters:customParameters];
}

#pragma mark - Error observer

- (void)errorOccurred:(BBCSMPError*)error
{
    self.currentItemContext.currentError = error;

    NSMutableDictionary* customParameters = [NSMutableDictionary dictionary];
    customParameters[@"xtc"] = [NSNumber numberWithDouble:self.currentItemContext.currentTime.seconds];
    if (_currentNetworkStatus.reachable) {
        if (_currentNetworkStatus.reachableViaWifi) {
            customParameters[@"xmc"] = @"wifi";
        }
        else {
            customParameters[@"xmc"] = @"3g";
        }
    }

    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           [avConsumer trackAVError:[error.error localizedDescription]
                                                       playlistTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                          assetTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                    currentLocation:weakSelf.isLive ? 0 : weakSelf.currentItemContext.currentDuration.seconds
                                                   customParameters:[NSDictionary dictionaryWithDictionary:customParameters]];
                                       }];
}

#pragma mark - Subtitles observer

- (void)subtitleAvailabilityChanged:(NSNumber*)available
{
}

- (void)subtitleActivationChanged:(NSNumber*)active
{
    self.subtitlesActive = [active boolValue];

    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           [avConsumer trackAVSubtitlesEnabled:weakSelf.subtitlesActive];
                                       }];
}

- (void)styleDictionaryUpdated:(NSDictionary*)styleDictionary baseStyleKey:(NSString *)baseStyleKey
{
}

- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle*>*)subtitles
{
}

#pragma mark - Player size observer

- (void)playerSizeChanged:(BBCSMPSize*)playerSize
{
    self.playerSize = playerSize;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           [avConsumer trackAVPlayerSizeChange:playerSize.size];
                                       }];
}

#pragma mark - Network status observer

- (void)networkStatusChanged:(BBCSMPNetworkStatus*)status
{
    self.currentNetworkStatus = status;
}

#pragma mark - Heartbeat generator delegate

- (void)sendAVStatisticsHeartbeatForElapsedPlaybackTime:(NSUInteger)elapsedPlaybackTime
{
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAVStatisticsConsumer)
                                       withBlock:^(id<BBCSMPAVStatisticsConsumer> avConsumer) {
                                           [avConsumer trackAVPlayingForSubtitlesActive:weakSelf.subtitlesActive
                                                                           playlistTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                              assetTime:[weakSelf.heartbeatGenerator elapsedPlaybackTime]
                                                                        currentLocation:weakSelf.isLive ? 0 : weakSelf.currentItemContext.currentTime.seconds
                                                                          assetDuration:weakSelf.isLive ? self.timeRange.end : weakSelf.currentItemContext.currentDuration.seconds];
                                       }];
}

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata *)preloadMetadata {
    self.preloadMetadata = preloadMetadata;
}

@end
