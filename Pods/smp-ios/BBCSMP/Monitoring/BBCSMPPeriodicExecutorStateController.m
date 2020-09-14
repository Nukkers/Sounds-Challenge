//
//  BBCSMPPeriodicExecutorStateController.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 17/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPPeriodicExecutorStateController.h"
#import "BBCSMPPeriodicExecutor.h"
#import "BBCSMPState.h"

@interface BBCSMPPeriodicExecutorStateController ()

@property (nonatomic, strong) BBCSMPPeriodicExecutor* periodicExecutor;

@end

#pragma mark -

@implementation BBCSMPPeriodicExecutorStateController

#pragma mark Initialization

- (instancetype)initWithPeriodicExecutor:(BBCSMPPeriodicExecutor*)periodicExecutor
{
    self = [super init];
    if (self) {
        _periodicExecutor = periodicExecutor;
    }

    return self;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    switch (state.state) {
    case BBCSMPStatePlaying:
    case BBCSMPStateBuffering:
        [self.periodicExecutor start];
        break;

    default:
        [self.periodicExecutor stop];
        break;
    }
}

@end
