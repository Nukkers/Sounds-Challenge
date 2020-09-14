//
//  BBCSMPAVErrorLogObserver.m
//  SMP
//
//  Created by Richard Gilpin on 19/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPAVErrorLogObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPNotificationReceptionist.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVFailedToLoadPlaylistEvent.h"
#import "BBCSMPError.h"
#import "BBCSMPAVCriticalErrorEvent.h"

NSString const * BBCSMPAVCoreMediaErrorDomain = @"CoreMediaErrorDomain";
NSInteger const BBCSMPAVCoreMediaFailedToLoadPlaylistErrorCode = -12884;

@implementation BBCSMPAVErrorLogObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPEventBus *_eventBus;
    BBCSMPNotificationReceptionist* _receptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext *)context
                                  eventBus:(BBCSMPEventBus *)eventBus
{
    self = [super init];
    if (self) {
        _context = context;
        _eventBus = eventBus;
        _receptionist = [BBCSMPNotificationReceptionist receptionistWithNotificationName:AVPlayerItemNewErrorLogEntryNotification
                                                           postedFromNotificationCenter:[NSNotificationCenter defaultCenter]
                                                                             fromObject:context.playerItem
                                                                         callbackWorker:context.callbackWorker
                                                                                 target:self
                                                                               selector:@selector(playerErrorLogUpdated:)];
    }
    
    return self;
}

#pragma mark Notification Callback

- (void)playerErrorLogUpdated:(NSNotification*)notification
{
    AVPlayerItem *playerItem = (AVPlayerItem *)notification.object;
    AVPlayerItemErrorLog *errorLog = playerItem.errorLog;
    AVPlayerItemErrorLogEvent *event = errorLog.events.lastObject;
    
    if (event.errorStatusCode == BBCSMPAVCoreMediaFailedToLoadPlaylistErrorCode &&
        [BBCSMPAVCoreMediaErrorDomain isEqualToString:event.errorDomain]) {
        BBCSMPAVFailedToLoadPlaylistEvent *event = [BBCSMPAVFailedToLoadPlaylistEvent event];
        [_eventBus sendEvent:event];
    }
}

@end
