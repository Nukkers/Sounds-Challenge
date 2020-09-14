//
//  BBCSMPPeriodicExecutorStateController.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 17/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPStateObserver.h"

@class BBCSMPPeriodicExecutor;

@interface BBCSMPPeriodicExecutorStateController : NSObject <BBCSMPStateObserver>

- (instancetype)initWithPeriodicExecutor:(BBCSMPPeriodicExecutor*)periodicExecutor;

@end
