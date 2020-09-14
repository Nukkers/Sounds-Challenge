//
//  BBCSMPUIDefaultConfiguration.h
//  BBCSMP
//
//  Created by Michael Emmens on 13/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPUIConfiguration.h"

@interface BBCSMPUIDefaultConfiguration : NSObject <BBCSMPUIConfiguration>

@property (nonatomic, assign) BOOL titleBarEnabled;
@property (nonatomic, assign) BOOL hideTitleBarLabels;
@property (nonatomic, assign) BOOL fullscreenEnabled;
@property (nonatomic, assign) BOOL subtitlesEnabled;
@property (nonatomic, assign) BOOL airplayEnabled;
@property (nonatomic, assign) BOOL pictureInPictureEnabled;
@property (nonatomic, assign) BBCSMPStandInPlayButtonStyle standInPlayButtonStyle;
@property (nonatomic, assign) BOOL autoplay;
@property (nonatomic, assign) BOOL allowPortrait;
@property (nonatomic, assign) NSTimeInterval inactivityPeriod;
@property (nonatomic, assign) BOOL volumeSliderHidden;
@property (nonatomic, assign) BOOL liveRewindEnabled;
@property (nonatomic, assign) NSTimeInterval liveIndicatorEdgeTolerance;
@property (nonatomic, assign) NSTimeInterval accessibilityStillBufferingAnnouncementDelay;
@property (nonatomic, assign) NSTimeInterval accessibilityScrubAdjustmentValue;
@property (nonatomic, assign) float minimumSubtitlesSize;
@property (nonatomic, assign) BBCSMPTitleBarCloseButtonAlignment closeButtonAlignment;

- (instancetype)initWithConfiguration:(id<BBCSMPUIConfiguration>)configuration;

@end
