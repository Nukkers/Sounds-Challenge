//
//  BBCSMPTelemetryManager.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPClockTime;
@class BBCSMPEventBus;
@protocol BBCSMP;
@protocol BBCSMPCommonAVReporting;
@protocol BBCSMPSessionIdentifierProvider;

@interface BBCSMPTelemetryManager : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
            AVMonitoringClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient
                      eventBus:(BBCSMPEventBus *)eventBus
     sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider NS_DESIGNATED_INITIALIZER;

- (void)clockDidTickToTime:(BBCSMPClockTime *)clockTime;

@end

NS_ASSUME_NONNULL_END
