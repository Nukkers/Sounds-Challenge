//
//  BBCSMPLocalPlayerItemProviderBuilder.m
//  SMP
//
//  Created by Stuart Thomas on 15/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPLocalPlayerItemProviderBuilder.h"
#import "BBCSMPLocalPlayerItemProvider.h"

@implementation BBCSMPLocalPlayerItemProviderBuilder

-(id<BBCSMPItemProvider>)buildForURL:(NSURL*)url andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer {
    BBCSMPLocalPlayerItemProvider* provider = [[BBCSMPLocalPlayerItemProvider alloc] initWithURL:url andAVStatisticsConsumer:avStatisticsConsumer];
    [self setValuesOnProvider:provider];
    return provider;
}

- (id<BBCSMPItemProvider>)buildForURL:(NSURL *)url andSubtitleURL:(NSURL *)subtitleUrl andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer {
    BBCSMPLocalPlayerItemProvider* provider = [[BBCSMPLocalPlayerItemProvider alloc] initWithURL:url andSubtitleURL: subtitleUrl andAVStatisticsConsumer:avStatisticsConsumer];
    [self setValuesOnProvider:provider];
    return provider;
}

- (instancetype)withAVType:(BBCSMPAVType)avType
{
    _avType = avType;
    return self;
}

-(instancetype)withTitle:(NSString *)title
{
    _title = title;
    return self;
}

- (instancetype)withSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
    return self;
}

- (instancetype)withDuration:(BBCSMPDuration *)duration
{
    _duration = duration;
    return self;
}

- (instancetype)withArtworkURLProvider:(id<BBCSMPArtworkURLProvider>)artworkURLProvider
{
    _artworkURLProvider = artworkURLProvider;
    return self;
}

- (instancetype)withPlayOffset:(NSTimeInterval)playOffset
{
    _playOffset = playOffset;
    return self;
}

- (instancetype)withCustomAvStatsLabels:(NSDictionary<NSString*, NSString*>*)customAvStatsLabels {
    _customAvStatsLabels = customAvStatsLabels;
    return self;
}

- (void)setValuesOnProvider:(BBCSMPLocalPlayerItemProvider*)provider{
    provider.avType = _avType;
    provider.title = _title;
    provider.subtitle = _subtitle;
    provider.duration = _duration;
    provider.artworkURLProvider = _artworkURLProvider;
    provider.playOffset = _playOffset;
    provider.customAvStatsLabels = _customAvStatsLabels;
}


@end
