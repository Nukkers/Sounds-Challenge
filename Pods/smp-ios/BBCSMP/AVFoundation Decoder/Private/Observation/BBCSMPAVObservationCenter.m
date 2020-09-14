//
//  BBCSMPAVDecoderObservationCenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVAccessLogObserver.h"
#import "BBCSMPAVBufferingObserver.h"
#import "BBCSMPAVDidPlayToEndTimeObserver.h"
#import "BBCSMPAVDurationObserver.h"
#import "BBCSMPAVFailedToPlayToEndTimeObserver.h"
#import "BBCSMPAVMutedObserver.h"
#import "BBCSMPAVObservationCenter.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVPeriodicObserver.h"
#import "BBCSMPAVRateObserver.h"
#import "BBCSMPAVSeekableTimeRangesObserver.h"
#import "BBCSMPAVPlayerItemStatusObserver.h"
#import "BBCSMPAVVideoRectObserver.h"
#import "BBCSMPAVVolumeObserver.h"
#import "BBCSMPAVErrorLogObserver.h"
#import "BBCSMPEventBus.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVObservationCenter {
    CMTime _updateFrequency;
    BBCSMPEventBus *_eventBus;
    id<AVPlayerProtocol> _player;
    AVPlayerLayer *_playerLayer;
    BBCSMPAVExternalPlaybackAdapter *_externalPlaybackAdapter;
    BBCSMPAVSeekableRangeCache *_seekableRangeCache;
    id<BBCSMPWorker> _callbackWorker;
    BBCSMPAVObservationContext* _sharedContext;
    NSArray *_observers;
    __weak id<BBCSMPDecoderDelegate> _delegate;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                          player:(id<AVPlayerProtocol>)player
                     playerLayer:(AVPlayerLayer *)playerLayer
                 updateFrequency:(CMTime)updateFrequency
         externalPlaybackAdapter:(BBCSMPAVExternalPlaybackAdapter *)externalPlaybackAdapter
              seekableRangeCache:(BBCSMPAVSeekableRangeCache *)seekableRangeCache
                  callbackWorker:(id<BBCSMPWorker>)callbackWorker
{
    self = [super init];
    if (self) {
        _updateFrequency = updateFrequency;
        _eventBus = eventBus;
        _player = player;
        _playerLayer = playerLayer;
        _externalPlaybackAdapter = externalPlaybackAdapter;
        _seekableRangeCache = seekableRangeCache;
        _callbackWorker = callbackWorker;
        _observers = [NSArray array];
        
        [eventBus addTarget:self selector:@selector(playerItemDidChange:) forEventType:[BBCSMPAVPlayerItemChangedEvent class]];
        [eventBus addTarget:self selector:@selector(decoderDelegateDidChange:) forEventType:[BBCSMPAVDecoderDelegateDidChangeEvent class]];
    }
    
    return self;
}

#pragma mark Domain Event Handlers

- (void)playerItemDidChange:(BBCSMPAVPlayerItemChangedEvent *)event
{
    BBCSMPAVObservationContext* context = [[BBCSMPAVObservationContext alloc] initWithPlayer:_player
                                                                                  playerItem:event.playerItem
                                                                             decoderDelegate:_delegate
                                                                              callbackWorker:_callbackWorker];

    _observers = @[
            // Player Observers
            [[BBCSMPAVRateObserver alloc] initWithObservationContext:context eventBus:_eventBus],
            [[BBCSMPAVMutedObserver alloc] initWithObservationContext:context],
            [[BBCSMPAVVolumeObserver alloc] initWithObservationContext:context],
            [[BBCSMPAVVideoRectObserver alloc] initWithObservationContext:context decoderLayer:_playerLayer],
            [[BBCSMPAVPeriodicObserver alloc] initWithEventBus:_eventBus observationContext:context updateFrequency:_updateFrequency],

            // Player Item Observers
            [[BBCSMPAVBufferingObserver alloc] initWithObservationContext:context eventBus:_eventBus],
            [[BBCSMPAVPlayerItemStatusObserver alloc] initWithObservationContext:context eventBus:_eventBus],
            [[BBCSMPAVSeekableTimeRangesObserver alloc] initWithObservationContext:context seekableRangeCache:_seekableRangeCache],
            [[BBCSMPAVDurationObserver alloc] initWithObservationContext:context seekableRangeCache:_seekableRangeCache],
            [[BBCSMPAVAccessLogObserver alloc] initWithObservationContext:context],
            [[BBCSMPAVDidPlayToEndTimeObserver alloc] initWithObservationContext:context],
            [[BBCSMPAVFailedToPlayToEndTimeObserver alloc] initWithObservationContext:context eventBus:_eventBus],
            [[BBCSMPAVErrorLogObserver alloc] initWithObservationContext:context eventBus:_eventBus]
    ];
    
    _sharedContext = context;
}

- (void)decoderDelegateDidChange:(BBCSMPAVDecoderDelegateDidChangeEvent *)event
{
    id<BBCSMPDecoderDelegate>  decoderDelegate = [event decoderDelegate];
    _delegate = decoderDelegate;
    _sharedContext.decoderDelegate = decoderDelegate;
}

@end
