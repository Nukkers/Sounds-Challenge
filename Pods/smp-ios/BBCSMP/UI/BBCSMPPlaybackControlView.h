//
//  BBCSMPPlaybackControlView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPBrandable.h"
#import "BBCSMPPlaybackControlsScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPUserInteractionObserver.h"
#import <UIKit/UIKit.h>
#import "BBCSMPPlayCTAButtonScene.h"
#import "BBCSMPTransportControlView.h"

@protocol BBCSMP;
@protocol BBCSMPTransportControlsScene;
@protocol BBCSMPScrubberScene;
@protocol BBCSMPLiveIndicatorScene;
@protocol BBCSMPVolumeScene;
@protocol BBCSMPFullscreenScene;
@protocol BBCSMPPictureInPictureButtonScene;
@protocol BBCSMPSubtitlesButtonScene;
@protocol BBCSMPTimeLabelScene;
@protocol BBCSMPAirplayButtonScene;
@protocol BBCSMPMeasurementPolicy;

@class BBCSMPMeasurementPolicies;

@protocol BBCSMPPlaybackControlViewDelegate

- (void)scrubberVisibilityUpdated:(BOOL)scrubberHidden;

@end

@interface BBCSMPPlaybackControlView : UIView <BBCSMPPlaybackControlsScene, BBCSMPBrandable, BBCSMPObserver>

@property (nonatomic, weak) id<BBCSMP> player;
@property (nonatomic, weak) id<BBCSMPPlaybackControlViewDelegate> delegate;

@property (nonatomic, readonly) BBCSMPTransportControlView *transportControlView;
@property (nonatomic, readonly) id<BBCSMPTransportControlsScene> transportControlsScene;
@property (nonatomic, readonly) id<BBCSMPScrubberScene> scrubberScene;
@property (nonatomic, readonly) id<BBCSMPLiveIndicatorScene> liveIndicatorScene;
@property (nonatomic, readonly) id<BBCSMPVolumeScene> volumeScene;
@property (nonatomic, readonly) id<BBCSMPFullscreenScene> fullscreenButtonScene;
@property (nonatomic, readonly) id<BBCSMPPlayCTAButtonScene> playCTAButtonScene;
@property (nonatomic, readonly) id<BBCSMPPictureInPictureButtonScene> pictureInPictureButtonScene;
@property (nonatomic, readonly) id<BBCSMPSubtitlesButtonScene> subtitlesButtonScene;
@property (nonatomic, readonly) id<BBCSMPTimeLabelScene> timeLabelScene;
@property (nonatomic, readonly) id<BBCSMPAirplayButtonScene> airplayButtonScene;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder*)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame
                configuration:(id<BBCSMPUIConfiguration>)configuration
          measurementPolicies:(BBCSMPMeasurementPolicies *)measurementPolicies NS_DESIGNATED_INITIALIZER;

- (void)addButton:(UIView*)button;
- (void)removeButton:(UIView*)button;

@end
