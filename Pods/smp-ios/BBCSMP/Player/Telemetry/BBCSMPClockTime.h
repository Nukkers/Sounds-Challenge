//
//  BBCSMPClockTime.h
//  BBCSMP
//
//  Created by Tim Condon on 16/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ClockTime)
@interface BBCSMPClockTime : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) long seconds;

+ (instancetype)timeWithSeconds:(NSTimeInterval)seconds NS_SWIFT_NAME(time(seconds:));
- (instancetype)initWithSeconds:(NSTimeInterval)seconds NS_DESIGNATED_INITIALIZER;

- (long)secondsSinceTime:(BBCSMPClockTime *)time;

@end

NS_ASSUME_NONNULL_END
