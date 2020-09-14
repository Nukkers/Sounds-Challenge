//
//  BBCSMPUserInteractionObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPUserInteractionObserver <BBCSMPObserver>

- (void)playButtonTapped;
- (void)pauseButtonTapped;
- (void)stopButtonTapped;
- (void)scrubbedToPosition:(NSNumber*)position NS_SWIFT_NAME(scrubbed(to:));
- (void)activateSubtitlesButtonTapped;
- (void)deactivateSubtitlesButtonTapped;
- (void)muteButtonTapped;
- (void)unmuteButtonTapped;
- (void)volumeSliderDisplayed;
- (void)volumeSliderHidden;
- (void)volumeChanged:(NSNumber*)volume;
- (void)enterFullscreenButtonTapped;
- (void)leaveFullscreenButtonTapped;
- (void)startPictureInPictureTapped;
- (void)stopPictureInPictureTapped;

@end
