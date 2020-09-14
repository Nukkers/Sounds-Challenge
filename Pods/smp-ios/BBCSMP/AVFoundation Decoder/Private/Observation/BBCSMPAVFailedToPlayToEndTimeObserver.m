//
//  BBCSMPAVDecoderFailedToPlayToEndTimeObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVFailedToPlayToEndTimeObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPError.h"
#import "BBCSMPNotificationReceptionist.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVCriticalErrorEvent.h"
#import "BBCSMPAVFailedToPlayToEndTimeEvent.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVFailedToPlayToEndTimeObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPNotificationReceptionist* _receptionist;
    BBCSMPEventBus* _eventBus;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                                  eventBus:(BBCSMPEventBus*)eventBus
{
    self = [super init];
    if (self) {
        _context = context;
        _receptionist = [BBCSMPNotificationReceptionist receptionistWithNotificationName:AVPlayerItemFailedToPlayToEndTimeNotification
                                                           postedFromNotificationCenter:[NSNotificationCenter defaultCenter]
                                                                             fromObject:context.playerItem
                                                                         callbackWorker:context.callbackWorker
                                                                                 target:self
                                                                               selector:@selector(failedToPlayToEndTime:)];
        _eventBus = eventBus;
    }

    return self;
}

#pragma mark Notification Callback

- (void)failedToPlayToEndTime:(NSNotification*)notification
{
    BBCSMPAVFailedToPlayToEndTimeEvent *event = [BBCSMPAVFailedToPlayToEndTimeEvent event];
    [_eventBus sendEvent:event];
}

@end
