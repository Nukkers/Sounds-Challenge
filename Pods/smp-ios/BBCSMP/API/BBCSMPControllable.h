//
//  BBCSMPControllable.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@class BBCSMPBitrate;
@protocol BBCSMPItemProvider;

@protocol BBCSMPControllable <NSObject>

@property (nonatomic, strong) id<BBCSMPItemProvider> playerItemProvider;

- (void)prepareToPlay;
- (void)play;
- (void)playFromOffset:(NSTimeInterval)offsetSeconds BBC_SMP_DEPRECATED("Please configure custom play offsets using -[BBCSMPMediaSelectorPlayerItemProvider setPlayOffset:]");
- (void)pause;
- (void)stop;
- (void)increasePlayRate;
- (void)decreasePlayRate;
- (void)scrubToPosition:(NSTimeInterval)position NS_SWIFT_NAME(scrub(to:));
- (void)activateSubtitles;
- (void)deactivateSubtitles;
- (void)mute;
- (void)unmute;
- (void)changeVolume:(float)volume;
- (void)transitionToPictureInPicture;
- (void)exitPictureInPicture;
- (void)limitMaximumPeakPlaybackBitrateToBitrate:(BBCSMPBitrate *)maximumPeakPlaybackBitrate;
- (void)removeMaximumPeakPlaybackBitrateLimit;

@end
