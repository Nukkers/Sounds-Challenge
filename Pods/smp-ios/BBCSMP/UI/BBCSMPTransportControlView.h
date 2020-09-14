//
//  BBCSMPTransportControlView.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAirplayButton.h"
#import "BBCSMPBrandable.h"
#import "BBCSMPFullscreenButton.h"
#import "BBCSMPLiveIndicator.h"
#import "BBCSMPPictureInPictureButton.h"
#import "BBCSMPSubtitleButton.h"
#import "BBCSMPTransportControlsScene.h"
#import "BBCSMPTimeLabel.h"
#import "BBCSMPSubtitlesButtonScene.h"
#import "BBCSMPAirplayButtonScene.h"
#import "BBCSMPPictureInPictureButtonScene.h"
#import "BBCSMPFullscreenScene.h"
#import "BBCSMPPlayButtonScene.h"
#import "BBCSMPPauseButtonScene.h"
#import "BBCSMPStopButtonScene.h"
#import <MediaPlayer/MPVolumeView.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@protocol BBCSMPUIConfiguration;
@protocol BBCSMPMeasurementPolicy;
@class BBCSMPIconButton;
@class BBCSMPVolumeView;
@class BBCSMPMeasurementPolicies;
@class BBCSMPButtonBar;

@protocol BBCSMPTransportControlViewDelegate <NSObject>

- (void)userInteractionStarted;
- (void)userInteractionEnded;
- (void)playButtonTapped;
- (void)pauseButtonTapped;
- (void)stopButtonTapped;
- (void)subtitleButtonTapped;
- (void)fullscreenButtonTapped;
- (void)pictureInPictureButtonTapped;
- (void)volumeSliderHidden;
- (void)muted;
- (void)unmuted;
- (void)volumeChanged:(float)volume;

@end

@interface BBCSMPTransportControlView : UIView <BBCSMPTransportControlsScene,
                                                BBCSMPAirplayButtonScene,
                                                BBCSMPSubtitlesButtonScene,
                                                BBCSMPPictureInPictureButtonScene,
                                                BBCSMPFullscreenScene,
                                                BBCSMPBrandable,
                                                BBCSMPPlayButtonScene,
                                                BBCSMPPauseButtonScene,
                                                BBCSMPStopButtonScene>

@property (nonatomic, strong, readonly) BBCSMPIconButton *playButton;
@property (nonatomic, strong, readonly) BBCSMPIconButton *pauseButton;
@property (nonatomic, strong, readonly) BBCSMPIconButton *stopButton;

@property (nonatomic, strong, readonly) BBCSMPAirplayButton* airplayButton;
@property (nonatomic, strong, readonly) BBCSMPSubtitleButton* subtitleButton;
@property (nonatomic, strong, readonly) BBCSMPFullscreenButton* fullscreenButton;
@property (nonatomic, strong, readonly) BBCSMPPictureInPictureButton* pictureInPictureButton;
@property (nonatomic, strong, readonly) BBCSMPLiveIndicator* liveIndicator;
@property (nonatomic, strong, readonly) BBCSMPTimeLabel* timeLabel;
@property (nonatomic, weak, nullable) id<BBCSMPTransportControlViewDelegate> transportControlsDelegate;
@property (nonatomic, strong, readonly) BBCSMPVolumeView* volumeSliderView;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame
          measurementPolicies:(BBCSMPMeasurementPolicies *)measurementPolicies;

- (void)addButton:(UIView*)button;
- (void)removeButton:(UIView*)button;

@end

NS_ASSUME_NONNULL_END
