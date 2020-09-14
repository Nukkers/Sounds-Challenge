//
//  BBCSMPHeartbeatManager.h
//  BBCSMP
//
//  Created by Tim Condon on 16/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPStateObserver.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPPlayerBitrateObserver.h"
#import "BBCSMPAirplayObserver.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPClockTime;
@class BBCSMPEventBus;
@class BBCSMPTelemetryLastRequestedItemTracker;
@protocol BBCSMPCommonAVReporting;
@protocol BBCSMPSessionIdentifierProvider;

@interface BBCSMPHeartbeatManager : NSObject <BBCSMPStateObserver, BBCSMPTimeObserver, BBCSMPPlayerBitrateObserver, BBCSMPAirplayObserver>

-(instancetype) init NS_UNAVAILABLE;
-(instancetype) initWithAVMonitoringClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient eventBus:(BBCSMPEventBus *)eventBus sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider lastRequestedItemTracker:(BBCSMPTelemetryLastRequestedItemTracker*)lastRequestedItemTracker
    NS_DESIGNATED_INITIALIZER;

- (void)clockDidTickToTime:(BBCSMPClockTime *)clockTime;

@end

NS_ASSUME_NONNULL_END
