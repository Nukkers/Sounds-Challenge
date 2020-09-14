//
//  BBCSMPClockTime.m
//  BBCSMP
//
//  Created by Tim Condon on 16/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPClockTime.h"

@implementation BBCSMPClockTime

- (instancetype)initWithSeconds:(NSTimeInterval)seconds
{
    if ((self = [super init])) {
        _seconds = (long) floor(seconds);
    }
    return self;
}

+ (instancetype)timeWithSeconds:(NSTimeInterval)seconds
{
    return [[BBCSMPClockTime alloc] initWithSeconds: seconds];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]])
        return NO;
    
    BBCSMPClockTime* time = (BBCSMPClockTime*)object;
    
    return ([time seconds] == _seconds);
}

- (long)secondsSinceTime:(BBCSMPClockTime *)time
{
    return _seconds - time.seconds;
}

@end
