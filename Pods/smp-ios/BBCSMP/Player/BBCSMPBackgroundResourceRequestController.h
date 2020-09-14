//
//  BBCSMPBackgroundTimeRequestController.h
//  httpclient-ios
//
//  Created by Ryan Johnstone on 30/10/2017.
//

#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPBackgroundTaskScheduler.h"
#import "BBCSMPStateObserver.h"

@interface BBCSMPBackgroundResourceRequestController : NSObject <BBCSMPStateObserver>

- (instancetype)initWithBackgroundTimeProvider:(id<BBCSMPBackgroundTaskScheduler>)backgroundTimeProvider backgroundStateProvider:(id<BBCSMPBackgroundStateProvider>)backgroundStateProvider;
@end
