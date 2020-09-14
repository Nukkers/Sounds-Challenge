//
//  BBCSMPTimeFormatter.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 22/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPTimeFormatter.h"

static NSDateFormatter* __BBCSMPTimeFormatterDateFormatter;
static NSDateFormatter* __BBCSMPTimeFormatterReadableDateFormatter;

@implementation BBCSMPTimeFormatter

+ (NSDateFormatter*)sharedDateFormatter
{
    if (!__BBCSMPTimeFormatterDateFormatter) {
        __BBCSMPTimeFormatterDateFormatter = [[NSDateFormatter alloc] init];
        [__BBCSMPTimeFormatterDateFormatter setDateFormat:@"HH:mm"];
    }
    return __BBCSMPTimeFormatterDateFormatter;
}

+ (NSDateFormatter*)sharedReadableDateFormatter
{
    if (!__BBCSMPTimeFormatterReadableDateFormatter) {
        __BBCSMPTimeFormatterReadableDateFormatter = [[NSDateFormatter alloc] init];
        [__BBCSMPTimeFormatterReadableDateFormatter setDateStyle:NSDateFormatterNoStyle];
        [__BBCSMPTimeFormatterReadableDateFormatter setTimeStyle:NSDateFormatterLongStyle];
    }
    return __BBCSMPTimeFormatterReadableDateFormatter;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _showLeadingZero = YES;
    }
    return self;
}

- (NSString*)stringFromDuration:(BBCSMPDuration*)duration
{
    return [self stringFromTimeInterval:duration.seconds];
}

- (NSString*)stringFromTime:(BBCSMPTime*)time
{
    switch (time.type) {
    case BBCSMPTimeRelative: {
        return [self stringFromTimeInterval:time.seconds];
    }
    case BBCSMPTimeAbsolute: {
        return [self stringFromDate:time.secondsAsDate];
    }
    default: {
        return @"";
    }
    }
}

- (NSString*)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger remainingSeconds = (NSInteger)interval;
    NSInteger seconds = remainingSeconds % 60;
    NSInteger minutes = (remainingSeconds / 60) % 60;
    NSInteger hours = (remainingSeconds / 3600);
    if (hours > 0) {
        return [NSString stringWithFormat:_showLeadingZero ? @"%02zd:%02zd:%02zd" : @"%zd:%02zd:%02zd", hours, minutes, seconds];
    } else {
        return [NSString stringWithFormat:_showLeadingZero ? @"%02zd:%02zd" : @"%zd:%02zd", minutes, seconds];
    }
}

- (NSString*)stringFromDate:(NSDate*)date
{
    return [[[self class] sharedDateFormatter] stringFromDate:date];
}

- (NSString*)readableStringFromDuration:(BBCSMPDuration*)duration
{
    return [self readableStringFromTimeInterval:duration.seconds];
}

- (NSString*)readableStringFromTime:(BBCSMPTime*)time
{
    switch (time.type) {
    case BBCSMPTimeRelative: {
        return [self readableStringFromTimeInterval:time.seconds];
    }
    case BBCSMPTimeAbsolute: {
        return [self readableStringFromDate:time.secondsAsDate];
    }
    default: {
        return nil;
    }
    }
}

- (NSString*)pluralisedString:(NSString*)noun value:(NSInteger)value
{
    NSMutableString* result = [NSMutableString string];
    [result appendFormat:@"%zd %@", value, noun];
    if (value != 1) {
        [result appendString:@"s"];
    }
    return [NSString stringWithString:result];
}

- (NSString*)readableStringFromTimeInterval:(NSTimeInterval)interval
{
    NSMutableArray* result = [NSMutableArray array];
    NSInteger remainingSeconds = (NSInteger)interval;

    NSInteger seconds = remainingSeconds % 60;
    NSInteger minutes = (remainingSeconds / 60) % 60;
    NSInteger hours = (remainingSeconds / 3600);

    if (hours) {
        [result addObject:[self pluralisedString:@"hour" value:hours]];
    }
    if (minutes) {
        [result addObject:[self pluralisedString:@"minute" value:minutes]];
    }
    if (seconds) {
        [result addObject:[self pluralisedString:@"second" value:seconds]];
    }

    return [result componentsJoinedByString:@", "];
}

- (NSString*)readableStringFromDate:(NSDate*)date
{
    return [[[self class] sharedReadableDateFormatter] stringFromDate:date];
}

@end
