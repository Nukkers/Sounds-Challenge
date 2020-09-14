//
//  BBCSMPStaticURLPlayerItemProvider.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 17/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPMediaSelectorItem.h"
#import "BBCSMPNetworkArtworkFetcher.h"
#import "BBCSMPStaticURLPlayerItemProvider.h"
#import "BBCSMPItemMetadata.h"

@interface BBCSMPStaticURLPlayerItemProvider ()

@property (nonatomic, copy) NSURL* URL;
@property (nonatomic, copy) NSURL* subtitleURL;

@end

@implementation BBCSMPStaticURLPlayerItemProvider

- (instancetype)initWithURL:(NSURL*)URL avStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer
{
    if ((self = [super init])) {
        _URL = URL;
        _playOffset = 0;
        _versionId = @"";
        _avStatisticsConsumer = avStatisticsConsumer;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL*)URL andSubtitleURL:(NSURL*)subtitleURL andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer
{
    if (self = [self initWithURL:URL avStatisticsConsumer:avStatisticsConsumer]) {
        _subtitleURL = subtitleURL;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL*)URL andSubtitleURL:(NSURL*)subtitleURL andVersionId:(NSString*)versionId andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer
{
    if (self = [self initWithURL:URL andSubtitleURL:subtitleURL andAVStatisticsConsumer:avStatisticsConsumer]) {
        _versionId = versionId;
    }
    return self;
}

#pragma - Item - provider implementation

- (void)requestPreloadMetadata:(BBCSMPItemProviderPreloadMetadataSuccess)success failure:(BBCSMPItemProviderFailure)failure
{
    BBCSMPItemPreloadMetadata* preloadMetadata = [BBCSMPItemPreloadMetadata new];
    [self configurePreloadMetadata:preloadMetadata];
    success(preloadMetadata);
}

- (void)requestPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure
{
    BBCSMPMediaSelectorItem* item = [[BBCSMPMediaSelectorItem alloc] init];
    item.mediaURL = _URL;
    item.subtitleURL = _subtitleURL;
    [self configurePreloadMetadata:item.metadata.preloadMetadata];
    [self configureMetadata:item.metadata];
    item.playOffset = _playOffset;
    dispatch_async(dispatch_get_main_queue(), ^{
        success(item);
    });
}

- (void)requestFailoverPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure
{
    NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    failure(error);
}

- (void)configureMetadata:(BBCSMPItemMetadata*)metadata
{
    metadata.avType = _avType;
    metadata.streamType = _streamType;
    metadata.versionId = _versionId;
}

- (void)configurePreloadMetadata:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    preloadMetadata.title = _title;
    preloadMetadata.subtitle = _subtitle;
    preloadMetadata.duration = _duration;
    [self configureMetadata:preloadMetadata.partialMetadata];
    if (self.artworkURLProvider) {
        BBCSMPNetworkArtworkFetcher* bbcSMPNetworkArtworkFetcher = [[BBCSMPNetworkArtworkFetcher alloc] init];
        bbcSMPNetworkArtworkFetcher.artworkURLProvider = _artworkURLProvider;
        preloadMetadata.artworkFetcher = bbcSMPNetworkArtworkFetcher;
    }
}

@synthesize avStatisticsConsumer = _avStatisticsConsumer;

@end
