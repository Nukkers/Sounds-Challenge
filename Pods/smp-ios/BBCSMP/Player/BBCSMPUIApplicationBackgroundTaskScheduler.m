 //
//  BBCSMPUIApplicationBackgroundTaskScheduler.m
//  SMP
//
//  Created by Ryan Johnstone on 31/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUIApplicationBackgroundTaskScheduler.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPUIApplicationBackgroundTaskScheduler

- (BBCSMPBackgroundTaskID)beginBackgroundTaskWithExpirationCallback:(void (^)(void))callback
{
#if SMP_APPLICATION_EXTENSION
    return 0;
#else
    return [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:callback];
#endif
}

- (void)endBackgroundTaskWithIdentifier:(BBCSMPBackgroundTaskID)identifier
{
#if !SMP_APPLICATION_EXTENSION
    [[UIApplication sharedApplication] endBackgroundTask:identifier];
#endif
}
    
@end
