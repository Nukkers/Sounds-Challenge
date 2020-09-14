//
//  BBCSMPPlayerScenes.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPActivityScene;
@protocol BBCSMPPlaybackControlsScene;
@protocol BBCSMPTransportControlsScene;
@protocol BBCSMPScrubberScene;
@protocol BBCSMPTitleBarScene;
@protocol BBCSMPTitleSubtitleScene;
@protocol BBCSMPLiveIndicatorScene;
@protocol BBCSMPVolumeScene;
@protocol BBCSMPFullscreenScene;
@protocol BBCSMPCloseButtonScene;
@protocol BBCSMPErrorMessageScene;
@protocol BBCSMPGuidanceMessageScene;
@protocol BBCSMPOverlayScene;
@protocol BBCSMPPlayCTAButtonScene;
@protocol BBCSMPBufferingIndicatorScene;
@protocol BBCSMPPictureInPictureButtonScene;
@protocol BBCSMPSubtitlesButtonScene;
@protocol BBCSMPTimeLabelScene;
@protocol BBCSMPSubtitleScene;
@protocol BBCSMPVideoSurfaceScene;
@protocol BBCSMPContentPlaceholderScene;
@protocol BBCSMPAirplayButtonScene;
@protocol BBCSMPPlayButtonScene;
@protocol BBCSMPPauseButtonScene;
@protocol BBCSMPStopButtonScene;
@protocol BBCSMPDisableSubtitlesButtonScene;
@protocol BBCSMPEnableSubtitlesButtonScene;

@protocol BBCSMPPlayerScenes <NSObject>
@required

@property (nonatomic, readonly) id<BBCSMPActivityScene> activityScene;
@property (nonatomic, readonly) id<BBCSMPPlaybackControlsScene> playbackControlsScene;
@property (nonatomic, readonly) id<BBCSMPTransportControlsScene> transportControlsScene;
@property (nonatomic, readonly) id<BBCSMPScrubberScene> scrubberScene;
@property (nonatomic, readonly) id<BBCSMPTitleBarScene> titleBarScene;
@property (nonatomic, readonly) id<BBCSMPTitleSubtitleScene> titleSubtitleScene;
@property (nonatomic, readonly) id<BBCSMPLiveIndicatorScene> liveIndicatorScene;
@property (nonatomic, readonly) id<BBCSMPVolumeScene> volumeScene;
@property (nonatomic, readonly) id<BBCSMPFullscreenScene> fullscreenButtonScene;
@property (nonatomic, readonly) id<BBCSMPCloseButtonScene> closeButtonScene;
@property (nonatomic, readonly) id<BBCSMPErrorMessageScene> errorMessageScene;
@property (nonatomic, readonly) id<BBCSMPGuidanceMessageScene> guidanceMessageScene;
@property (nonatomic, readonly) id<BBCSMPOverlayScene> overlayScene;
@property (nonatomic, readonly) id<BBCSMPPlayCTAButtonScene> playCTAButtonScene;
@property (nonatomic, readonly) id<BBCSMPBufferingIndicatorScene> bufferingIndicatorScene;
@property (nonatomic, readonly) id<BBCSMPPictureInPictureButtonScene> pictureInPictureButtonScene;
@property (nonatomic, readonly) id<BBCSMPSubtitlesButtonScene> subtitlesButtonScene;
@property (nonatomic, readonly) id<BBCSMPTimeLabelScene> timeLabelScene;
@property (nonatomic, readonly) id<BBCSMPSubtitleScene> subtitlesScene;
@property (nonatomic, readonly) id<BBCSMPVideoSurfaceScene> videoSurfaceScene;
@property (nonatomic, readonly) id<BBCSMPContentPlaceholderScene> contentPlaceholderScene;
@property (nonatomic, readonly) id<BBCSMPAirplayButtonScene> airplayButtonScene;
@property (nonatomic, readonly) id<BBCSMPPlayButtonScene> playButtonScene;
@property (nonatomic, readonly) id<BBCSMPPauseButtonScene> pauseButtonScene;
@property (nonatomic, readonly) id<BBCSMPStopButtonScene> stopButtonScene;
@property (nonatomic, readonly) id<BBCSMPDisableSubtitlesButtonScene> disableSubtitlesScene;
@property (nonatomic, readonly) id<BBCSMPEnableSubtitlesButtonScene> enableSubtitlesScene;

@end

NS_ASSUME_NONNULL_END
