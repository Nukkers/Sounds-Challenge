//
//  BBCSMPTimeRange.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSTimeInterval const kBBCSMPTimeRangeMinimumSeekableDurationForLiveRewind;

@interface BBCSMPTimeRange : NSObject

@property (nonatomic, assign) NSTimeInterval rangeStartOffset;
@property (nonatomic, assign) NSTimeInterval start;
@property (nonatomic, assign) NSTimeInterval end;
@property (nonatomic, readonly) BOOL durationMeetsMinimumLiveRewindRequirement;

+ (instancetype)zeroTimeRange;
+ (instancetype)rangeWithStart:(NSTimeInterval)start end:(NSTimeInterval)end NS_SWIFT_NAME(init(start:end:));

@end

NS_ASSUME_NONNULL_END
