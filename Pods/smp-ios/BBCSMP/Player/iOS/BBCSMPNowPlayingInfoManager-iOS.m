//
//  BBCSMPNowPlayingInfoManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPNowPlayingInfoManager.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPDuration.h"
#import "BBCSMPTime.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPTimeObserver.h"
#import "MPNowPlayingInfoCenterProtocol.h"
#import <MediaPlayer/MPMediaItem.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPRemoteCommand.h>
#import <MediaPlayer/MPRemoteCommandCenter.h>

@interface BBCSMPNowPlayingInfoManager () <BBCSMPPreloadMetadataObserver, BBCSMPTimeObserver>

@property (nonatomic, strong) id<BBCSMPArtworkFetcher> artworkFetcher;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) id<MPNowPlayingInfoCenterProtocol> infoCenter;

@end

@implementation BBCSMPNowPlayingInfoManager

- (instancetype)initWithPlayer:(id<BBCSMP>)player
          nowPlayingInfoCenter:(id<MPNowPlayingInfoCenterProtocol>)nowPlayingInfoCenter
{
    if ((self = [super init])) {
        _infoCenter = nowPlayingInfoCenter;
        [player addObserver:self];
    }
    
    return self;
}

- (NSString*)artistName
{
    return [self applicationName];
}

- (NSString*)applicationName
{
    NSDictionary* appInfo = [[NSBundle mainBundle] infoDictionary];
    if ([[appInfo allKeys] containsObject:@"CFBundleDisplayName"]) {
        return [appInfo objectForKey:@"CFBundleDisplayName"];
    }
    else {
        return [appInfo objectForKey:@"CFBundleName"];
    }
}

- (void)updateTitle:(NSString*)title
{
    NSMutableDictionary* nowPlayingDict = [NSMutableDictionary dictionaryWithDictionary:_infoCenter.nowPlayingInfo];
    [nowPlayingDict setObject:self.artistName ? self.artistName : @"" forKey:MPMediaItemPropertyArtist];
    [nowPlayingDict setObject:title ? title : @"" forKey:MPMediaItemPropertyTitle];
    [_infoCenter setNowPlayingInfo:nowPlayingDict];
}

- (void)updateArtworkImage:(UIImage*)image
{
    if (image) {
        NSMutableDictionary* nowPlayingDict = [NSMutableDictionary dictionaryWithDictionary:_infoCenter.nowPlayingInfo];
        MPMediaItemArtwork* artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [nowPlayingDict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        [_infoCenter setNowPlayingInfo:nowPlayingDict];
    }
}

- (void)updateDuration:(BBCSMPDuration*)duration
{
    if (duration != nil && duration.seconds != 0.0) {
        self.duration = duration.seconds;
        NSMutableDictionary* nowPlayingDict = [NSMutableDictionary dictionaryWithDictionary:_infoCenter.nowPlayingInfo];
        [nowPlayingDict setObject:[NSNumber numberWithDouble:duration.seconds] forKey:MPMediaItemPropertyPlaybackDuration];
        [nowPlayingDict setObject:[NSNumber numberWithInt:0] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        [_infoCenter setNowPlayingInfo:nowPlayingDict];
    }
}

#pragma mark - Time observer
- (void)durationChanged:(BBCSMPDuration*)duration
{
    [self updateDuration:duration];
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range {}

- (void)timeChanged:(BBCSMPTime*)time
{
    NSMutableDictionary* nowPlayingDict = [NSMutableDictionary dictionaryWithDictionary:_infoCenter.nowPlayingInfo];
    [nowPlayingDict setObject:[NSNumber numberWithDouble:time.seconds] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [nowPlayingDict setObject:[NSNumber numberWithDouble:self.duration] forKey:MPMediaItemPropertyPlaybackDuration];
    [_infoCenter setNowPlayingInfo:nowPlayingDict];
}

- (void)playerRateChanged:(float)playerRate
{
    NSMutableDictionary* nowPlayingDict = [NSMutableDictionary dictionaryWithDictionary:_infoCenter.nowPlayingInfo];
    [nowPlayingDict setObject:[NSNumber numberWithFloat:playerRate] forKey:MPNowPlayingInfoPropertyPlaybackRate];
    [_infoCenter setNowPlayingInfo:nowPlayingDict];
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime {}

#pragma mark - Player item observer

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    if (preloadMetadata != nil) {
        [self updateTitle:preloadMetadata.title];

        if (self.artworkFetcher == preloadMetadata.artworkFetcher) {
            return;
        }

        self.artworkFetcher = preloadMetadata.artworkFetcher;
        __weak typeof(self) weakSelf = self;
        [_artworkFetcher fetchArtworkImageAtSize:CGSizeMake(240, 240)
            scale:[[UIScreen mainScreen] scale]
            success:^(UIImage* artworkImage) {
                [weakSelf updateArtworkImage:artworkImage];
            }
            failure:^(NSError* artworkError){
            }];
    }
}

@end
