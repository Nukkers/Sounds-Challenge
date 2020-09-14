//
//  BBCSMPTelemetryErrorManager.h
//  Pods
//
//  Created by Ryan Johnstone on 26/06/2017.
//
//

#import "BBCSMPDefines.h"
#import "BBCSMPPlayerBitrateObserver.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;
@class BBCSMPTelemetryLastRequestedItemTracker;
@protocol BBCSMPCommonAVReporting;
@protocol BBCSMPSessionIdentifierProvider;

@interface BBCSMPTelemetryErrorManager : NSObject <BBCSMPPlayerBitrateObserver>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithAVMonitoringClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient
                                  eventBus:(BBCSMPEventBus *)eventBus
                 sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider
                  lastRequestedItemTracker:(BBCSMPTelemetryLastRequestedItemTracker *)lastRequestedItemTracker NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
