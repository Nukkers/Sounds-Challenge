//
//  BBCSMPSystemTimeIntervalFormatter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSystemTimeIntervalFormatter.h"

@implementation BBCSMPSystemTimeIntervalFormatter {
    NSDateComponentsFormatter *_dateComponentsFormatter;
    NSDateFormatter *_dateFormatter;
}

#pragma mark Initialization

- (instancetype)init
{
    NSLocale *locale = [NSLocale currentLocale];
    return [self initWithLocale:locale];
}

- (instancetype)initWithLocale:(NSLocale *)locale
{
    self = [super init];
    if(self) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        calendar.locale = locale;
        
        _dateComponentsFormatter = [[NSDateComponentsFormatter alloc] init];
        _dateComponentsFormatter.allowedUnits = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        _dateComponentsFormatter.calendar = calendar;
        _dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.calendar = calendar;
        _dateFormatter.dateStyle = NSDateFormatterNoStyle;
        _dateFormatter.locale = locale;
        _dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    }
    
    return self;
}

#pragma mark BBCSMPTimeIntervalFormatter

- (NSString *)stringFromSeconds:(NSTimeInterval)seconds
{
    return [_dateComponentsFormatter stringFromTimeInterval:seconds];
}

- (NSString *)stringFromDate:(NSDate *)date
{
    return [_dateFormatter stringFromDate:date];
}

@end
