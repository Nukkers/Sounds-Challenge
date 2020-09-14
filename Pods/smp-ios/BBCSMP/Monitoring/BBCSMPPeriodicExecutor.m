//
//  BBCSMPPeriodicExecutor.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 16/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPPeriodicExecutor.h"

@interface BBCSMPPeriodicExecutor ()

@property (nonatomic, assign, readwrite) NSTimeInterval periodInterval;
@property (nonatomic, assign, readwrite, getter=isRunning) BOOL running;
@property (nonatomic, strong) NSRecursiveLock* lock;
@property (nonatomic, strong) NSTimer* timer;

@end

#pragma mark -

@implementation BBCSMPPeriodicExecutor

#pragma mark Deallocation

- (void)dealloc
{
    [self stop];
}

#pragma mark Initialization

- (instancetype)init
{
    return self = [self initWithPeriodInterval:1.0];
}

- (instancetype)initWithPeriodInterval:(NSTimeInterval)periodInterval
{
    return self = [self initWithPeriodInterval:periodInterval delegate:nil];
}

- (instancetype)initWithPeriodInterval:(NSTimeInterval)periodInterval delegate:(nullable id<BBCSMPPeriodicExecutorDelegate>)delegate
{
    self = [super init];
    if (self) {
        _periodInterval = periodInterval;
        _running = NO;
        _lock = [NSRecursiveLock new];
        _delegate = delegate;
        _immediatelyInvokeCallback = YES;
    }

    return self;
}

#pragma mark Execution Start/Stopping

- (void)performBlock:(void (^)(BBCSMPPeriodicExecutor*))block
{
    [_lock lock];
    block(self);
    [_lock unlock];
}

- (void)start
{
    [self performBlock:^(BBCSMPPeriodicExecutor* executor) {
        if (executor.isRunning) {
            return;
        }

        executor.timer = [NSTimer timerWithTimeInterval:executor.periodInterval target:executor selector:@selector(periodicTimerCallback:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:executor.timer forMode:NSRunLoopCommonModes];
        executor.running = YES;

        if (executor.immediatelyInvokeCallback) {
            [executor notifyDelegatePeriodElapsed];
        }
    }];
}

- (void)stop
{
    //TODO: should this be called from dealloc - nstimer holds a strong reference
    [self performBlock:^(BBCSMPPeriodicExecutor* executor) {
        if (!executor.isRunning) {
            return;
        }

        [executor.timer invalidate];
        executor.running = NO;
    }];
}

#pragma mark Timer Callback

- (void)periodicTimerCallback:(NSTimer*)timer
{
    [self notifyDelegatePeriodElapsed];
}

- (void)notifyDelegatePeriodElapsed
{
    if ([self.delegate respondsToSelector:@selector(periodicExecutorPeriodDidElapse:)]) {
        [self.delegate periodicExecutorPeriodDidElapse:self];
    }
}

@end
