//
//  BBCSMPDecoder.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CALayer;
@class BBCSMPDuration;
@class BBCSMPTime;
@class BBCSMPTimeRange;
@protocol BBCSMPResolvedContent;
@protocol BBCSMPExternalPlaybackAdapter;
@protocol BBCSMPDecoderDelegate;
@protocol BBCSMPPictureInPictureAdapter;
@protocol BBCSMPDecoderLayer;

@protocol BBCSMPDecoder <NSObject>

@property (nonatomic, strong, nullable) id<BBCSMPDecoderDelegate> delegate;
@property (nonatomic, nullable, readonly) CALayer<BBCSMPDecoderLayer>* decoderLayer;
@property (nonatomic, getter=isMuted) BOOL muted;
@property (nonatomic) float volume;

@property (nonatomic, readonly) BBCSMPDuration* duration;
@property (nonatomic, readonly) BBCSMPTimeRange* seekableRange;

@property (nonatomic, readonly) id<BBCSMPPictureInPictureAdapter> pictureInPictureAdapter;
@property (nonatomic, readonly) id<BBCSMPExternalPlaybackAdapter> externalPlaybackAdapter;

- (void)play;
- (void)pause;
- (float)increasePlayRate;
- (float)decreasePlayRate;
- (void)teardown;
- (void)load:(id<BBCSMPResolvedContent>)resolvedContent;
- (void)scrubToAbsoluteTimeInterval:(NSTimeInterval)absoluteTimeInterval NS_SWIFT_NAME(scrub(toAbsoluteTime:));
- (void)setContentFit;
- (void)setContentFill;
- (void)restrictPeakBitrateToBitsPerSecond:(double)preferredPeakBitRate;
- (void)removePeakBitrateRestrictions;

@end

NS_ASSUME_NONNULL_END
