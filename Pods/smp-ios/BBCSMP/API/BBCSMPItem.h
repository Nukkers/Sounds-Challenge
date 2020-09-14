//
//  BBCSMPItem.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPItemMetadata;
@class BBCSMPItemBitrateRestrictions;
@protocol BBCSMPResolvedContent;
@protocol BBCSMPArtworkFetcher;
@protocol BBCSMPSubtitleFetcher;

typedef NS_ENUM(NSUInteger, BBCSMPBackgroundAction) {
    BBCSMPBackgroundActionDefault = 0,
    BBCSMPBackgroundActionPausePlayback,
    BBCSMPBackgroundActionTeardownPlayer
};

@protocol BBCSMPItem <NSObject>

@property (nonatomic, readonly) id<BBCSMPResolvedContent> resolvedContent;

- (BBCSMPItemMetadata*)metadata;
- (void)teardown;
- (BOOL)allowsAirplay;
- (BOOL)allowsExternalDisplay;

@optional

- (BBCSMPBackgroundAction)actionOnBackground;

// Providing subtitles: Implement subtitleFetcher to use your own custom
// fetching for programme artwork. To use the standard network fetching behaviour,
// implement subtitleURL to return a URL and leave subtitleFetcher unimplemented.
- (nullable id<BBCSMPSubtitleFetcher>)subtitleFetcher;
- (nullable NSURL*)subtitleURL;

// These methods are just here to provide a workaround for downloads in iPlayer -
// they are called before/after attaching the AVPlayerItem returned by prepareForPlayback
// to an instance of AVPlayer - you should not need to implement them.
- (void)willAttachToPlayer;
- (void)didAttachToPlayer;

// This allows you to provide bitrate restrictions that will be used to set
// preferredPeakBitrate for the item in specified scenarios on iOS 8 and above
- (BBCSMPItemBitrateRestrictions*)bitrateRestrictions BBC_SMP_DEPRECATED("Apply bitrate caps using - [BBCSMPControllable applyBitrateCap:]");

// Specify the offset in seconds from the start where playback will start
@property (nonatomic, assign) NSTimeInterval playOffset BBC_SMP_DEPRECATED("Please configure custom play offsets using BBCSMPItemProvider's playOffset");

@end

NS_ASSUME_NONNULL_END
