//
//  BBCSMPPlayerContext.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPPlayerContext.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPSize.h"
#import "BBCSMPPlayerSizeObserver.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPTime.h"
#import "BBCSMPVideoRectObserver.h"
#import "BBCSMPPlayer.h"
#import "BBCSMPError.h"
#import "BBCSMPErrorObserver.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPSettingsPersistence.h"
#import "BBCSMPVolumeObserver.h"
#import "BBCSMPPlayerInitialisationContext.h"
#import "BBCSMPState.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPVolumeProvider.h"
#import "BBCSMPDecoder.h"

@interface BBCSMPPlayerContext () <BBCSMPVolumeProviderDelegate>
@end

@implementation BBCSMPPlayerContext {
    BBCSMPObserverManager *_observerManager;
    __weak BBCSMPPlayer *_player;
    id<BBCSMPSettingsPersistence> _settingsPersistence;
}

- (instancetype)initWithPlayer:(BBCSMPPlayer *)player context:(BBCSMPPlayerInitialisationContext *)context
{
    self = [super init];
    if(self) {
        _observerManager = [[BBCSMPObserverManager alloc] init];
        _player = player;
        _context = context;

        _volumeProvider = context.volumeProvider;
        [_volumeProvider setDelegate:self];
        [self setVolume:_volumeProvider.currentVolume];
    }
    return self;
}

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [_observerManager addObserver:observer];
}

- (void)removeObserver:(id<BBCSMPObserver>)observer
{
    [_observerManager removeObserver:observer];
}

- (void)notifyObserversForProtocol:(Protocol*)proto withBlock:(void (^)(id observer))block
{
    [_observerManager notifyObserversForProtocol:proto withBlock:block];
}

- (void)setPlayerSize:(BBCSMPSize*)playerSize
{
    if ([_playerSize isEqual:playerSize])
        return;
    
    _playerSize = playerSize;
    [self notifyObserversForProtocol:@protocol(BBCSMPPlayerSizeObserver) withBlock:^(id<BBCSMPPlayerSizeObserver> observer) {
        [observer playerSizeChanged:playerSize];
    }];
}

- (void)setTime:(BBCSMPTime*)time
{
    if ([_time isEqual:time])
        return;
    
    _time = time;
    
    [self notifyObserversForProtocol:@protocol(BBCSMPTimeObserver) withBlock:^(id<BBCSMPTimeObserver> observer) {
        [observer timeChanged:time];
    }];
}

- (void)setVideoRect:(CGRect)videoRect
{
    _videoRect = videoRect;
    __weak typeof(_player) weakPlayer = _player;
    [self notifyObserversForProtocol:@protocol(BBCSMPVideoRectObserver) withBlock:^(id<BBCSMPVideoRectObserver> observer) {
        [observer player:weakPlayer videoRectDidChange:videoRect];
    }];
}

- (void)setSeekableRange:(BBCSMPTimeRange*)seekableRange
{
    if ([_seekableRange isEqual:seekableRange])
        return;

    _seekableRange = seekableRange;
    [self notifyObserversForProtocol:@protocol(BBCSMPTimeObserver) withBlock:^(id<BBCSMPTimeObserver> observer) {
        [observer seekableRangeChanged:seekableRange];
    }];
}

- (void)setPreloadMetadata:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    if ([_preloadMetadata isEqual:preloadMetadata])
        return;

    _preloadMetadata = preloadMetadata;

    BBCSMPItemPreloadMetadataUpdatedEvent *preloadMetadataUpdatedEvent =
    [[BBCSMPItemPreloadMetadataUpdatedEvent alloc] initWithPreloadMetdata:preloadMetadata];
    [_eventBus sendEvent:preloadMetadataUpdatedEvent];

    [self notifyObserversForProtocol:@protocol(BBCSMPPreloadMetadataObserver) withBlock:^(id<BBCSMPPreloadMetadataObserver> observer) {
        [observer preloadMetadataUpdated:preloadMetadata];
    }];
}

- (void)setIsMuted:(BOOL)isMuted
{
    if (_isMuted == isMuted)
        return;

    _isMuted = isMuted;
    [_settingsPersistence setMuted:_isMuted];
    [self notifyObserversForProtocol:@protocol(BBCSMPVolumeObserver) withBlock:^(id<BBCSMPVolumeObserver> observer) {
        [observer playerMuteStateChanged:@(isMuted)];
    }];
}

- (void)setVolume:(float)volume
{
    if (_volume == volume)
        return;

    _volume = volume;
    [self notifyObserversForProtocol:@protocol(BBCSMPVolumeObserver) withBlock:^(id<BBCSMPVolumeObserver> observer) {
        [observer playerVolumeChanged:@(volume)];
    }];
}

#pragma mark - BBCSMPVolumeProvider delegate methods

- (void)didUpdateVolume:(float)volume
{
    [_decoder setVolume:volume];
}

@end
