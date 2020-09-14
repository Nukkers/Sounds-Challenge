//
//  BBCSMPBackgroundTaskScheduler.h
//  BBCSMP
//
//  Created by Ryan Johnstone on 30/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSUInteger BBCSMPBackgroundTaskID;

@protocol BBCSMPBackgroundTaskScheduler <NSObject>

- (BBCSMPBackgroundTaskID)beginBackgroundTaskWithExpirationCallback:(void (^)(void))callback;
- (void)endBackgroundTaskWithIdentifier:(BBCSMPBackgroundTaskID)identifier NS_SWIFT_NAME(endBackgroundTask(identifier:));

@end

NS_ASSUME_NONNULL_END
