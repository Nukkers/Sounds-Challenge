//
//  BBCSMPDecoderDelegate.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPState.h"
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPError;
@class BBCSMPDecoderCurrentPosition;

NS_SWIFT_NAME(DecoderEvent)
@protocol BBCDecoderEvent
@end

@protocol BBCSMPDecoderDelegate <NSObject>

- (BBCSMPStateEnumeration)playerState;

- (void)decoderReady;
- (void)decoderPlaying;
- (void)decoderPaused;
- (void)decoderBuffering:(BOOL)buffering;
- (void)decoderFailed:(BBCSMPError*)error NS_SWIFT_NAME(decoderFailed(error:));
- (void)decoderFinished;
- (void)decoderMuted:(BOOL)muted;
- (void)decoderVolumeChanged:(float)volume NS_SWIFT_NAME(decoderVolumeChange(_:));
- (void)decoderVideoRectChanged:(CGRect)videoRect;
- (void)decoderBitrateChanged:(double)bitrate;
- (void)decoderInterrupted;
- (void)decoderPlayingPublicly;
- (void)decoderPlayingPrivatley;
- (void)decoderDidProgressToPosition:(BBCSMPDecoderCurrentPosition*)currentPosition;

@optional
- (void)decoderEventOccurred:(id<BBCDecoderEvent>)event;
@end

NS_ASSUME_NONNULL_END
