//
//  BBCSMPAVDecoderBufferingObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVBufferingObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVBufferingEvent.h"

static const NSString* AVPlayerItemPlaybackLikelyToKeepUpContext = @"AVPlayerItemPlaybackLikelyToKeepUpContext";

// Weirdly AVFoundation emits KVO notifications on "playbackLikelyToKeepUp",
// instead of it's getter "isPlaybackLikelyToKeepUp", which can't be accessed
// using @selector without a warning.
static NSString* AVPlayerItemPlaybackLikelyToKeepUpKey = @"playbackLikelyToKeepUp";
static const NSString* AVPlayerRateContext = @"AVPlayerRateContext";

@implementation BBCSMPAVBufferingObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPEventBus *_eventBus;
    BBCSMPKVOReceptionist* _playbackLikelyToKeepUpReceptionist;
    BBCSMPKVOReceptionist* _rateReceptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                                  eventBus:(BBCSMPEventBus*)eventBus
{
    self = [super init];
    if (self) {
        _context = context;
        _eventBus = eventBus;
        _playbackLikelyToKeepUpReceptionist = [BBCSMPKVOReceptionist receptionistWithSubject:context.playerItem
                                                               keyPath:AVPlayerItemPlaybackLikelyToKeepUpKey
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerItemPlaybackLikelyToKeepUpContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handlePlayerBufferingUpdate)];

        _rateReceptionist = [BBCSMPKVOReceptionist receptionistWithSubject:context.player
                                                               keyPath:NSStringFromSelector(@selector(rate))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerRateContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handlePlayerRateUpdate)];
    }

    return self;
}

#pragma mark Observation Callback

- (void)handlePlayerBufferingUpdate
{
    BOOL buffering = !_context.playerItem.playbackLikelyToKeepUp;

    if (_context.player.rate != 0) {
        [_eventBus sendEvent:[BBCSMPAVBufferingEvent eventWithBuffering:buffering]];
    }
}

- (void)handlePlayerRateUpdate
{
    if(_context.playerItem.playbackLikelyToKeepUp) {return;}

    [self handlePlayerBufferingUpdate];
}

@end
