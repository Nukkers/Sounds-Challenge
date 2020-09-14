//
//  BBCSMPTimer.m
//  BBCSMP
//
//  Created by Flavius Mester on 26/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPTimer.h"
#import "NSTimerProtocol.h"
#import "BBCSMPNSTimerFactory.h"

@implementation BBCSMPTimer {
    BOOL _isFiring;
}

- (instancetype)initWithInterval:(NSTimeInterval)interval target:(id)aTarget selector:(SEL)aSelector nsTimerFactory:(id<BBCSMPNSTimerFactoryProtocol>)nsTimerFactory
{
    self = [super init];
    if (self) {
        _interval = interval;
        _target = aTarget;
        _selector = aSelector;

        _timer = [nsTimerFactory scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(timeOutCallback:) userInfo:nil repeats:false];
    }

    return self;
}

- (void)stop
{
    if (!_isFiring) {
        [_timer invalidate];
        _selector = nil;
        _target = nil;
    }
}

- (void)timeOutCallback:(id<NSTimerProtocol>)timer
{
    _isFiring = YES;
    if (_target != nil && [_target respondsToSelector:_selector]) {
        IMP imp = [_target methodForSelector:_selector];
        void (*method)(id, SEL) = (void*)imp;
        method(_target, _selector);
    }

    _isFiring = NO;
    
    [self stop];
}

@end
