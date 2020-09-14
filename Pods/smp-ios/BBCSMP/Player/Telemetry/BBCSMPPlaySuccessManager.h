//
//  BBCSMPPlaySuccessManager.h
//  smp-ios
//
//  Created by Ryan Johnstone on 19/03/2018.
//

#import <Foundation/Foundation.h>
#import "BBCSMPStateObserver.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPTelemetryLastRequestedItemTracker;
@protocol BBCSMPAVTelemetryService;
@protocol BBCSMPSessionIdentifierProvider;

@interface BBCSMPPlaySuccessManager : NSObject <BBCSMPStateObserver>

-(instancetype) init NS_UNAVAILABLE;
-(instancetype)initWithAVMonitoringClient:(id)AVMonitoringClient sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider lastRequestedItemTracker:(nonnull BBCSMPTelemetryLastRequestedItemTracker *)lastRequestedItemTracker NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
