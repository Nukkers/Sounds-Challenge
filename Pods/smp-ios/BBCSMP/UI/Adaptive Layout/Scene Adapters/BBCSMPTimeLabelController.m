//
//  BBCSMPTimeLabelController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTimeLabelController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPTimeLabelController {
    UILabel *_relativeTimePlayheadLabel;
    UILabel *_relativeTimeDividerLabel;
    UILabel *_relativeTimeDurationLabel;
    UILabel *_absoluteTimeLabel;
}

#pragma mark Initialization

- (instancetype)initWithRelativeTimeLabel:(UILabel *)timeLabel
                 relativeTimeDividerLabel:(UILabel *)relativeTimeDividerLabel
                relativeTimeDurationLabel:(UILabel *)relativeTimeDurationLabel
                        absoluteTimeLabel:(UILabel *)absoluteTimeLabel
{
    self = [super init];
    if(self) {
        _relativeTimePlayheadLabel = timeLabel;
        _relativeTimeDividerLabel = relativeTimeDividerLabel;
        _relativeTimeDurationLabel = relativeTimeDurationLabel;
        _absoluteTimeLabel = absoluteTimeLabel;
    }
    
    return self;
}

#pragma mark BBCSMPTimeLabelScene

- (void)setRelativeTimeStringWithPlayheadPosition:(NSString *)playheadPosition duration:(NSString *)duration
{
    _absoluteTimeLabel.text = @"";
    _relativeTimePlayheadLabel.text = playheadPosition;
    _relativeTimeDurationLabel.text = duration;
    _relativeTimePlayheadLabel.hidden = NO;
    _relativeTimeDividerLabel.hidden = NO;
    _relativeTimeDurationLabel.hidden = NO;
    _absoluteTimeLabel.hidden = YES;
}

- (void)setAbsoluteTimeString:(NSString *)absoluteTimeString
{
    _relativeTimePlayheadLabel.text = @"";
    _relativeTimeDurationLabel.text = @"";
    _absoluteTimeLabel.text = absoluteTimeString;
    _absoluteTimeLabel.hidden = NO;
    _relativeTimePlayheadLabel.hidden = YES;
    _relativeTimeDividerLabel.hidden = YES;
    _relativeTimeDurationLabel.hidden = YES;
}

- (void)showTime
{
    
}

- (void)hideTime
{
    _relativeTimePlayheadLabel.hidden = YES;
    _relativeTimeDividerLabel.hidden = YES;
    _relativeTimeDurationLabel.hidden = YES;
    _absoluteTimeLabel.hidden = YES;
}

@end
