//
//  BBCSMPDefaultPeriodicExecutorFactory.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 10/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefaultPeriodicExecutorFactory.h"

@implementation BBCSMPDefaultPeriodicExecutorFactory

- (BBCSMPPeriodicExecutor*)createPeriodicExecutor:(NSTimeInterval)periodInterval
{
    return [[BBCSMPPeriodicExecutor alloc] initWithPeriodInterval:periodInterval];
}

@end
