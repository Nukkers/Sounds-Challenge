//
//  BBCSMPAVDecoderAccessLogObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVAccessLogObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPNotificationReceptionist.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVAccessLogObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPNotificationReceptionist* _receptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
{
    self = [super init];
    if (self) {
        _context = context;
        _receptionist = [BBCSMPNotificationReceptionist receptionistWithNotificationName:AVPlayerItemNewAccessLogEntryNotification
                                                           postedFromNotificationCenter:[NSNotificationCenter defaultCenter]
                                                                             fromObject:context.playerItem
                                                                         callbackWorker:context.callbackWorker
                                                                                 target:self
                                                                               selector:@selector(playerAccessLogUpdated:)];
    }

    return self;
}

#pragma mark Notification Callback

- (void)playerAccessLogUpdated:(NSNotification*)notification
{
    AVPlayerItemAccessLog* accessLog = _context.playerItem.accessLog;
    AVPlayerItemAccessLogEvent* event = [accessLog.events lastObject];

    [_context.decoderDelegate decoderBitrateChanged:event.indicatedBitrate];
    
}

@end
