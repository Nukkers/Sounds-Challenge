//
//  BBCSMPNSTimerClock.m
//  BBCSMP
//
//  Created by Raj Khokhar on 09/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPNSTimerClock.h"
#import "BBCSMPTime.h"
#import "BBCSMPClockTime.h"

@implementation BBCSMPNSTimerClock {
    __weak id<BBCSMPClockDelegate> _listener;
    NSTimer *_timer;
}

- (void)onTimeTick
{
    NSDate* date = [[NSDate alloc] init];
    BBCSMPClockTime* clockTime = [BBCSMPClockTime timeWithSeconds:date.timeIntervalSince1970];
    [_listener clockDidTickToTime:clockTime];
}

- (void)addClockDelegate:(id<BBCSMPClockDelegate>)clockListener
{
    _listener = clockListener;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(onTimeTick)
                                            userInfo:nil
                                             repeats:YES];
    [self onTimeTick];
}

- (void)stop
{
    [_timer invalidate];
}

@end
