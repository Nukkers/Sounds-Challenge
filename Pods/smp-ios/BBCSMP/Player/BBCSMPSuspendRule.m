//
//  BBCSMPSuspendRule.m
//  BBCSMP
//
//  Created by Raj Khokhar on 25/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPSuspendRule.h"

@interface BBCSMPSuspendRule ()

@property (nonatomic, assign) NSTimeInterval interval;

@end

@implementation BBCSMPSuspendRule

- (instancetype) initWithTimeInterval:(NSTimeInterval) interval {
    self = [super init];
    if (self != nil) {
        _interval = interval;
    }
    return self;
}

+ (instancetype) suspendAfter:(NSTimeInterval)seconds
{
    return [[BBCSMPSuspendRule alloc] initWithTimeInterval:seconds];
}

-(NSTimeInterval)intervalBeforeSuspend {
    return _interval;
}

@end
