//
//  BBCSMPSystemTimeProvider.m
//  BBCSMP
//
//  Created by Al Priest on 20/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPSystemTimerProvider.h"

@interface BBCSMPSystemTimerProvider ()
@property (nonatomic, strong) NSDate* startTime;
@end

@implementation BBCSMPSystemTimerProvider

- (void)start
{
    self.startTime = [NSDate date];
}

- (NSTimeInterval)durationSinceStart
{
    NSTimeInterval result = [[NSDate date] timeIntervalSince1970] - [self.startTime timeIntervalSince1970];
    return result;
}

@end
