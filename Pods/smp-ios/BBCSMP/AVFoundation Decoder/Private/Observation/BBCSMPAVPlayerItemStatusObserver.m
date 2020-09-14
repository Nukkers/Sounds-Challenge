//
//  BBCSMPAVPlayerItemStatusObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVPlayerItemStatusObserver.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVItemStatusChangedEvent.h"

static const NSString* AVPlayerItemStatusContext = @"AVPlayerStatusContext";

@implementation BBCSMPAVPlayerItemStatusObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPKVOReceptionist* _receptionist;
    BBCSMPEventBus* _eventBus;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                                  eventBus:(BBCSMPEventBus*)eventBus
{
    self = [super init];
    if (self) {
        _context = context;
        _eventBus = eventBus;
        _receptionist = [BBCSMPKVOReceptionist receptionistWithSubject:context.playerItem
                                                               keyPath:NSStringFromSelector(@selector(status))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerItemStatusContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handlePlayerStatusUpdate)];
    }
    
    return self;
}

#pragma mark Observation Callback

- (void)handlePlayerStatusUpdate
{
    AVPlayerItemStatus status = _context.playerItem.status;
    BBCSMPAVItemStatusChangedEvent *event = [BBCSMPAVItemStatusChangedEvent eventWithStatus:status];
    [_eventBus sendEvent:event];
}

@end
