//
// Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/04/2017.
// Copyright (c) 2017 BBC. All rights reserved.
//

#import "BBCSMPSuspendMechanism.h"
#import "BBCSMPSuspendRule.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPTimerFactory.h"

@interface BBCSMPSuspendMechanism ()

@property (nonatomic, strong) BBCSMPSuspendRule *suspendRule;
@property (nonatomic, strong) id<BBCSMPTimerProtocol> suspendTimer;
@property (nonatomic, strong) id<BBCSMPTimerFactoryProtocol> timerFactory;
@property (nonatomic, assign, readwrite, getter=isSuspended) BOOL suspended;
@property (nonatomic, copy) void(^suspensionCallback)(void);

@end

#pragma mark -

@implementation BBCSMPSuspendMechanism

- (instancetype)initWithTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
                   suspendRule:(BBCSMPSuspendRule*)suspendRule
            suspensionCallback:(void(^)(void))suspensionCallback
{
    self = [super init];
    if (self) {
        _timerFactory = timerFactory;
        _suspendRule = suspendRule;
        _suspensionCallback = suspensionCallback;
    }

    return self;
}

- (void) evaluateSuspendRule
{
    if (_suspendRule != nil) {
        [self cancelPendingSuspendTransition];
        _suspendTimer = [_timerFactory timerWithInterval:[_suspendRule intervalBeforeSuspend]
                                                  target:self
                                                selector:@selector(enterSuspendedState)];

    }
}

- (void) cancelPendingSuspendTransition
{
    [_suspendTimer stop];
    _suspended = NO;
}

- (void)enterSuspendedState
{
    _suspensionCallback();
    _suspended = YES; // TODO this should be reset somewhere, but needs a test Beazley
}

@end
