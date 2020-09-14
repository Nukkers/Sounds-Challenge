//
//  BBCSMPUIConfiguration.h
//  BBCSMP
//
//  Created by Michael Emmens on 13/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BBCSMPStandInPlayButtonStyle) {
    BBCSMPStandInPlayButtonStyleNone,
    BBCSMPStandInPlayButtonStyleIcon,
    BBCSMPStandInPlayButtonStyleIconAndDuration
};

typedef NS_ENUM(NSUInteger, BBCSMPTitleBarCloseButtonAlignment) {
    BBCSMPTitleBarCloseButtonAlignmentLeft,
    BBCSMPTitleBarCloseButtonAlignmentRight
};

@protocol BBCSMPUIConfiguration <NSObject, NSCopying>

- (BOOL)titleBarEnabled;
- (BBCSMPTitleBarCloseButtonAlignment)closeButtonAlignment;
- (BOOL)hideTitleBarLabels;
- (BOOL)fullscreenEnabled;
- (BOOL)subtitlesEnabled;
- (BOOL)airplayEnabled;
- (BOOL)pictureInPictureEnabled;
- (BBCSMPStandInPlayButtonStyle)standInPlayButtonStyle;
- (BOOL)autoplay;
- (BOOL)allowPortrait;  // On devices that are capable of displaying multiple applications simultaenously, this value will be overlooked, unless the client application specifies it `Requires full screen`. Otherwise, the fullscreen view controller, will not invoke the required methods to determine that landscape playback is only allowed.
- (NSTimeInterval)inactivityPeriod;
- (BOOL)volumeSliderHidden;
- (BOOL)liveRewindEnabled;
- (NSTimeInterval)liveIndicatorEdgeTolerance;
- (NSTimeInterval)accessibilityStillBufferingAnnouncementDelay;
- (NSTimeInterval)accessibilityScrubAdjustmentValue;

@optional
- (float)minimumSubtitlesSize;

@end
