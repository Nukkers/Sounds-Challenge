//
//  BBCSMPElapsedPlaybackHeartbeat.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPElapsedPlaybackHeartbeat.h"

@interface BBCSMPElapsedPlaybackHeartbeat ()

@property (nonatomic, strong) NSArray<NSDictionary*>* heartbeatIntervalRanges;

@property (nonatomic, strong) NSDate* lastUpdate;
@property (nonatomic, assign) NSTimeInterval elapsedPlaybackTimeInterval;
@property (nonatomic, assign) NSTimeInterval elapsedPlaybackTimeIntervalAtLastHeartbeat;
@property (nonatomic, strong) id<BBCSMPDateProvider> dateProvider;
@end

@implementation BBCSMPElapsedPlaybackHeartbeat

- (instancetype) init {
    return [self initWithDateProvider:[[BBCSMPCurrentDateProvider alloc] init]];
}

- (instancetype _Nonnull)initWithDateProvider:(id<BBCSMPDateProvider> _Nonnull)dateProvider
{
    if ((self = [super init])) {
        self.dateProvider = dateProvider;
        self.lastUpdate = [_dateProvider currentDate];
        self.heartbeatIntervalRanges = @[ @{ @"range" : [NSValue valueWithRange:NSMakeRange(0, 69)],
                                             @"interval" : @10.0 },
            @{ @"range" : [NSValue valueWithRange:NSMakeRange(70, NSUIntegerMax)],
                @"interval" : @60.0 } ];
    }
    return self;
}

- (NSUInteger)elapsedPlaybackTime
{
    return floor(_elapsedPlaybackTimeInterval);
}

- (NSTimeInterval)heartbeatInterval
{
    for (NSDictionary* heartbeatIntervalRange in _heartbeatIntervalRanges) {
        if (NSLocationInRange([self elapsedPlaybackTime], [heartbeatIntervalRange[@"range"] rangeValue])) {
            return [heartbeatIntervalRange[@"interval"] doubleValue];
        }
    }
    return [[_heartbeatIntervalRanges lastObject][@"interval"] doubleValue];
}

- (void)stateChanged:(BBCSMPState*)state
{
    if (state.state == BBCSMPStatePlaying) {
        self.lastUpdate = [_dateProvider currentDate];
    }
}

- (void)update
{
    NSDate* now = [_dateProvider currentDate];
    NSTimeInterval timeSinceLastUpdate = [now timeIntervalSinceDate:self.lastUpdate];
    self.lastUpdate = now;
    self.elapsedPlaybackTimeInterval += timeSinceLastUpdate;
    NSTimeInterval timeSinceLastHeartbeat = self.elapsedPlaybackTimeInterval - self.elapsedPlaybackTimeIntervalAtLastHeartbeat;
    NSTimeInterval heartbeatInterval = [self heartbeatInterval];
    if (timeSinceLastHeartbeat >= heartbeatInterval) {
        self.elapsedPlaybackTimeIntervalAtLastHeartbeat = self.elapsedPlaybackTimeInterval;
        [_delegate sendAVStatisticsHeartbeatForElapsedPlaybackTime:self.elapsedPlaybackTime];
    }
}

@end
