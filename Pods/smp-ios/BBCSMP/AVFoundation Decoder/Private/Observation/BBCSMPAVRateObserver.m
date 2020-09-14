//
//  BBCSMPAVRateObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVRateObserver.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"
#import "BBCSMPAVRateChangedEvent.h"
#import "BBCSMPEventBus.h"

static const NSString* AVPlayerRateContext = @"AVPlayerRateContext";

@implementation BBCSMPAVRateObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPKVOReceptionist* _receptionist;
    BBCSMPEventBus *_eventBus;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                                  eventBus:(BBCSMPEventBus *)eventBus
{
    self = [super init];
    if (self) {
        _context = context;
        _eventBus = eventBus;
        _receptionist = [BBCSMPKVOReceptionist receptionistWithSubject:context.player
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

- (void)handlePlayerRateUpdate
{
    BBCSMPAVRateChangedEvent *event = [[BBCSMPAVRateChangedEvent alloc] initWithRate:_context.player.rate];
    [_eventBus sendEvent:event];
}

@end
