//
//  BBCSMPTime.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 17/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPTime.h"

@interface BBCSMPTime ()

@property (nonatomic, assign) BBCSMPTimeType type;
@property (nonatomic, assign) NSTimeInterval seconds;
@property (nonatomic, strong) NSDate* secondsAsDate;

@end

@implementation BBCSMPTime

+ (instancetype)relativeTime:(NSTimeInterval)seconds
{
    return [[BBCSMPTime alloc] initWithSeconds:seconds];
}

- (instancetype)initWithSeconds:(NSTimeInterval)seconds
{
    if ((self = [super init])) {
        self.type = BBCSMPTimeRelative;
        self.seconds = seconds;
    }
    return self;
}

+ (instancetype)absoluteTime:(NSDate*)date
{
    return [[BBCSMPTime alloc] initWithDate:date];
}

- (instancetype)initWithDate:(NSDate*)date
{
    if ((self = [super init])) {
        self.type = BBCSMPTimeAbsolute;
        self.seconds = date.timeIntervalSince1970;
    }
    return self;
}

+ (instancetype)absoluteTimeWithIntervalSince1970:(NSTimeInterval)dateInSeconds
{
    return [[BBCSMPTime alloc] initWithTimeIntervalSince1970:dateInSeconds];
}

- (instancetype)initWithTimeIntervalSince1970:(NSTimeInterval)dateInSeconds
{
    if ((self = [super init])) {
        self.type = BBCSMPTimeAbsolute;
        self.seconds = dateInSeconds;
    }
    return self;
}

- (NSDate *)secondsAsDate {
    
    NSDate *result;
    
    if (self.type == BBCSMPTimeAbsolute) {
        result = [NSDate dateWithTimeIntervalSince1970:self.seconds];
    } else {
        result = nil;
    }
    
    return result;
}

- (NSString*)description
{
    NSString *description;
    
    switch (_type) {
        case BBCSMPTimeRelative: {
            description = [NSString stringWithFormat:@"%@ : Relative: %fs", [super description], _seconds];
        }
        break;
            
        case BBCSMPTimeAbsolute: {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.seconds];
            description = [NSString stringWithFormat:@"%@ : Absolute: %@ (%fs)", [date description], [super description], _seconds];
        }
        break;
            
    }

    return description;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]])
        return NO;

    BBCSMPTime* time = (BBCSMPTime*)object;
    if (_type != time.type)
        return NO;

    return ([time seconds] == _seconds);
}


- (NSInteger)differenceInSecondsTo:(BBCSMPTime *)otherTime {
    NSTimeInterval result = self.seconds - otherTime.seconds;
    return result;
}

@end
