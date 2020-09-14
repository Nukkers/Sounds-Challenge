//
//  BBCSMPTime.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 17/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BBCSMPTimeType) {
    BBCSMPTimeRelative = 0,
    BBCSMPTimeAbsolute
};

@interface BBCSMPTime : NSObject

@property (nonatomic, assign, readonly) BBCSMPTimeType type;
@property (nonatomic, assign, readonly) NSTimeInterval seconds;
@property (nonatomic, strong, readonly, nullable) NSDate* secondsAsDate;

+ (instancetype)relativeTime:(NSTimeInterval)seconds NS_SWIFT_NAME(relativeTime(_:));
+ (instancetype)absoluteTime:(NSDate*) date NS_SWIFT_NAME(absoluteTime(_:));
+ (instancetype)absoluteTimeWithIntervalSince1970:(NSTimeInterval) dateInSeconds NS_SWIFT_NAME(absoluteTime(secondsSince1970:));

- (NSInteger)differenceInSecondsTo:(BBCSMPTime *)otherTime;

@end

NS_ASSUME_NONNULL_END
