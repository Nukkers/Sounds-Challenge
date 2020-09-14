//
//  BBCSMPPeriodicExecutorFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 10/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPeriodicExecutor.h"

@protocol BBCSMPPeriodicExecutorFactory

- (BBCSMPPeriodicExecutor*)createPeriodicExecutor:(NSTimeInterval)periodInterval;

@end
