//
//  BBCSMPAVDecoderDidPlayToEndTimeObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVDidPlayToEndTimeObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPNotificationReceptionist.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVDidPlayToEndTimeObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPNotificationReceptionist* _receptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
{
    self = [super init];
    if (self) {
        _context = context;
        _receptionist = [BBCSMPNotificationReceptionist receptionistWithNotificationName:AVPlayerItemDidPlayToEndTimeNotification
                                                           postedFromNotificationCenter:[NSNotificationCenter defaultCenter]
                                                                             fromObject:context.playerItem
                                                                         callbackWorker:context.callbackWorker
                                                                                 target:self
                                                                               selector:@selector(didPlayToEndTime:)];
    }

    return self;
}

#pragma mark Notification Callback

- (void)didPlayToEndTime:(NSNotification*)notification
{
    [_context.decoderDelegate decoderFinished];
}

@end
