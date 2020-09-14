//
//  BBCSMPTimeRange.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPTimeRange.h"

NSTimeInterval const kBBCSMPTimeRangeMinimumSeekableDurationForLiveRewind = 300.0;

@implementation BBCSMPTimeRange

+ (instancetype)zeroTimeRange
{
    return [self rangeWithStart:0 end:0];
}

+ (instancetype)rangeWithStart:(NSTimeInterval)start end:(NSTimeInterval)end
{
    return [[BBCSMPTimeRange alloc] initWithStart:start end:end];
}

- (instancetype)initWithStart:(NSTimeInterval)start end:(NSTimeInterval)end
{
    if ((self = [super init])) {
        _start = start;
        _end = end;
    }
    return self;
}

- (BOOL)durationMeetsMinimumLiveRewindRequirement
{
    return (_end - _start) >= kBBCSMPTimeRangeMinimumSeekableDurationForLiveRewind;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %fs -> %fs", [super description], _start, _end];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]])
        return NO;

    BBCSMPTimeRange* timeRange = (BBCSMPTimeRange*)object;
    return (_start == timeRange.start && _end == timeRange.end);
}

@end
