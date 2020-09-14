//
//  BBCSMPAVPeriodicObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVPeriodicObserver.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVBufferingEvent.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVPeriodicObserver {
    BBCSMPAVObservationContext* _context;
    id _observationIdentifier;
}

#pragma mark Deallocation

- (void)dealloc
{
    [_context.player removeTimeObserver:_observationIdentifier];
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
              observationContext:(BBCSMPAVObservationContext *)context
                 updateFrequency:(CMTime)updateFrequency
{
    self = [super init];
    if (self) {
        _context = context;
        __weak BBCSMPAVObservationContext *weakContext = context;
        void(^playheadDidMove)(CMTime) = ^(CMTime time) {
            if (weakContext.playerItem.status != AVPlayerItemStatusReadyToPlay) {return;}
            BBCSMPAVPlayheadMovedEvent *event = [[BBCSMPAVPlayheadMovedEvent alloc] initWithPlayheadPosition:time];
            [eventBus sendEvent:event];
        };
        
        id player = [_context player];
        _observationIdentifier = [player addPeriodicTimeObserverForInterval:updateFrequency
                                                                      queue:dispatch_get_main_queue()
                                                                 usingBlock:playheadDidMove];
    }

    return self;
}

@end
