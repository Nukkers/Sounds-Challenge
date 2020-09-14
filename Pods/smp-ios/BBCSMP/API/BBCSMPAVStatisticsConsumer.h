//
//  BBCSMPAVStatisticsConsumer.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPItemMetadata.h"
#import "BBCSMPStatisticsConsumer.h"
#import <CoreGraphics/CGGeometry.h>
#import "BBCSMPTimeRange.h"
#import "BBCSMPTime.h"
#import "BBCSMPState.h"

@protocol BBCSMPAVStatisticsConsumer <BBCSMPStatisticsConsumer>

- (void)trackAVSessionStartForItemMetadata:(BBCSMPItemMetadata*)itemMetadata NS_SWIFT_NAME(trackAVSessionStart(itemMetadata:));
- (void)trackAVFullMediaLength:(NSInteger)mediaLengthInSeconds NS_SWIFT_NAME(trackAVFullMediaLength(lengthInSeconds:));
- (void)trackAVPlaybackWithCurrentLocation:(NSInteger)currentLocation customParameters:(NSDictionary*)customParameters NS_SWIFT_NAME(trackAVPlayback(currentLocation:customParameters:));
- (void)trackAVPlayingForSubtitlesActive:(BOOL)subtitlesActive playlistTime:(NSInteger)playlistTime assetTime:(NSInteger)assetTime currentLocation:(NSInteger)currentLocation assetDuration:(NSInteger)assetDuration NS_SWIFT_NAME(trackAVPlaying(subtitlesActive:playlistTime:assetTime:currentLocation:assetDuration:));
- (void)trackAVBufferForPlaylistTime:(NSInteger)playlistTime assetTime:(NSInteger)assetTime currentLocation:(NSInteger)currentLocation NS_SWIFT_NAME(trackAVBuffer(playlistTime:assetTime:currentLocation:));
- (void)trackAVPauseForPlaylistTime:(NSInteger)playlistTime assetTime:(NSInteger)assetTime currentLocation:(NSInteger)currentLocation NS_SWIFT_NAME(trackAVPause(playlistTime:assetTime:currentLocation:));
- (void)trackAVResumeForPlaylistTime:(NSInteger)playlistTime assetTime:(NSInteger)assetTime currentLocation:(NSInteger)currentLocation NS_SWIFT_NAME(trackAVResume(playlistTime:assetTime:currentLocation:));
- (void)trackAVScrubFromTime:(NSInteger)fromTime toTime:(NSInteger)toTime NS_SWIFT_NAME(trackAVScrub(from:to:));
- (void)trackAVEndForSubtitlesActive:(BOOL)subtitlesActive playlistTime:(NSInteger)playlistTime assetTime:(NSInteger)assetTime assetDuration:(NSInteger)assetDuration wasNatural:(BOOL)wasNatural withCustomParameters:(NSDictionary*)customParameters NS_SWIFT_NAME(trackAVEnd(subtitlesActive:playlistTime:assetTime:assetDuration:wasNatural:customParameters:));
- (void)trackAVSubtitlesEnabled:(BOOL)subtitlesEnabled NS_SWIFT_NAME(trackAVSubtitlesEnabled(_:));
- (void)trackAVPlayerSizeChange:(CGSize)playerSize NS_SWIFT_NAME(trackAVPlayerSizeChange(_:));
- (void)trackAVError:(NSString*)errorString playlistTime:(NSInteger)playlistTime assetTime:(NSInteger)assetTime currentLocation:(NSInteger)currentLocation customParameters:(NSDictionary*)customParameters NS_SWIFT_NAME(trackAVError(_:playlistTime:assetTime:currentLocation:customParameters:));

@optional
- (void)seekableRangeChanged:(BBCSMPTimeRange*)timeRange;
- (void)timeChanged:(BBCSMPTime*)time;
- (void)stateChanged:(BBCSMPState*)state;
- (void)customAvStatsLabelsChanged:(NSDictionary <NSString*, NSString*>*) customAvStatsLabels;

@end
