//
//  BBCSMPUIDefaultConfiguration.m
//  BBCSMP
//
//  Created by Michael Emmens on 13/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPUIDefaultConfiguration.h"

@implementation BBCSMPUIDefaultConfiguration

- (instancetype)init
{
    if ((self = [super init])) {
        self.fullscreenEnabled = YES;
        self.subtitlesEnabled = YES;
        self.airplayEnabled = YES;
        self.autoplay = YES;
        self.pictureInPictureEnabled = YES;
        self.inactivityPeriod = 8.0;
        self.volumeSliderHidden = YES;
        self.liveRewindEnabled = YES;
        self.liveIndicatorEdgeTolerance = 30.0;
        self.accessibilityStillBufferingAnnouncementDelay = 5.0;
        self.accessibilityScrubAdjustmentValue = 10.0;
        _minimumSubtitlesSize = 11;
        self.closeButtonAlignment = BBCSMPTitleBarCloseButtonAlignmentLeft;
    }
    return self;
}

- (instancetype)initWithConfiguration:(id<BBCSMPUIConfiguration>)configuration
{
    if ((self = [super init])) {
        _titleBarEnabled = [configuration titleBarEnabled];
        _hideTitleBarLabels = [configuration hideTitleBarLabels];
        _fullscreenEnabled = [configuration fullscreenEnabled];
        _subtitlesEnabled = [configuration subtitlesEnabled];
        _airplayEnabled = [configuration airplayEnabled];
        _standInPlayButtonStyle = [configuration standInPlayButtonStyle];
        _autoplay = [configuration autoplay];
        _allowPortrait = [configuration allowPortrait];
        _inactivityPeriod = [configuration inactivityPeriod];
        _pictureInPictureEnabled = [configuration pictureInPictureEnabled];
        _volumeSliderHidden = [configuration volumeSliderHidden];
        _liveRewindEnabled = [configuration liveRewindEnabled];
        _liveIndicatorEdgeTolerance = [configuration liveIndicatorEdgeTolerance];
        _accessibilityStillBufferingAnnouncementDelay = [configuration accessibilityStillBufferingAnnouncementDelay];
        _accessibilityScrubAdjustmentValue = [configuration accessibilityScrubAdjustmentValue];
        _closeButtonAlignment = [configuration closeButtonAlignment];
    }
    return self;
}

- (id)copyWithZone:(NSZone*)zone
{
    BBCSMPUIDefaultConfiguration *copy = [[BBCSMPUIDefaultConfiguration allocWithZone:zone] initWithConfiguration:self];
    [copy setMinimumSubtitlesSize:_minimumSubtitlesSize];
    
    return copy;
}

+ (NSString*)standInPlayButtonStyleAsString:(BBCSMPStandInPlayButtonStyle)standInPlayButtonStyle
{
    switch (standInPlayButtonStyle) {
        case BBCSMPStandInPlayButtonStyleNone:
            return @"None";
        case BBCSMPStandInPlayButtonStyleIcon:
            return @"IconOnly";
        case BBCSMPStandInPlayButtonStyleIconAndDuration:
            return @"IconAndDuration";
        default:
            return @"Invalid";
    }
}

- (NSString*)description
{
    return [@{ @"titleBarEnabled" : @(_titleBarEnabled),
        @"hideTitleBarLabels" : @(_hideTitleBarLabels),
        @"fullscreenEnabled" : @(_fullscreenEnabled),
        @"subtitlesEnabled" : @(_subtitlesEnabled),
        @"airplayEnabled" : @(_airplayEnabled),
        @"standInPlayButtonStyle" : [[self class] standInPlayButtonStyleAsString:_standInPlayButtonStyle],
        @"autoplay" : @(_autoplay),
        @"allowPortrait" : @(_allowPortrait),
        @"inactivityPeriod" : @(_inactivityPeriod),
        @"pictureInPictureEnabled" : @(_pictureInPictureEnabled),
        @"volumeSliderHidden" : @(_volumeSliderHidden),
        @"liveRewindEnabled" : @(_liveRewindEnabled),
        @"liveIndicatorEdgeTolerance" : @(_liveIndicatorEdgeTolerance),
        @"accessibilityStillBufferingAnnouncementDelay" : @(_accessibilityStillBufferingAnnouncementDelay),
        @"accessibilityScrubAdjustmentValue" : @(_accessibilityScrubAdjustmentValue) } description];
    
}

@end
