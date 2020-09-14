//
//  BBCSMPPlayerBuilder+Internal.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/04/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlayerBuilder.h"

@protocol BBCSMPRemoteControl;
@protocol BBCSMPBackgroundStateProvider;
@protocol BBCSMPAirplayAvailabilityProvider;
@protocol BBCSMPCommonAVReporting;
@protocol BBCSMPClock;
@protocol BBCSMPRemoteCommandCenter;
@protocol BBCSMPBackgroundTaskScheduler;

@interface BBCSMPPlayerBuilder ()

- (id<BBCSMPAirplayAvailabilityProvider>)airplayAvailabilityProvider;

- (instancetype)withBackgroundStateProvider:(id<BBCSMPBackgroundStateProvider>)backgroundStateProvider;
- (instancetype)withAirplayAvailabilityProvider:(id<BBCSMPAirplayAvailabilityProvider>)airplayAvailabilityProvider;
- (instancetype)withCommonAVReportingClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient;
- (instancetype)withBBCSMPClock:(id<BBCSMPClock>)clock;
- (instancetype)withBackgroundResourceProvider:(id<BBCSMPBackgroundTaskScheduler>)backgroundTimeProvider;
- (instancetype)withHeartbeatGenerator:(id<BBCSMPAVStatisticsHeartbeatGenerator>)hbg;
- (instancetype)withSystemSuspension:(id<BBCSMPSystemSuspension>)systemSuspension;

- (void)disableRdot;

@end
