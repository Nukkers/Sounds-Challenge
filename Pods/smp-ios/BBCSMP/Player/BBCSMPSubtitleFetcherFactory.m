//
//  BBCSMPSubtitleFetcherFactory.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 07/08/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleFetcherFactory.h"
#import "BBCSMPItem.h"
#import "BBCSMPNetworkSubtitleFetcher.h"

@implementation BBCSMPSubtitleFetcherFactory

+ (id<BBCSMPSubtitleFetcher>)subtitleFetcherForItem:(id<BBCSMPItem>)item
{
    id<BBCSMPSubtitleFetcher> fetcher = nil;
    if ([item respondsToSelector:@selector(subtitleFetcher)] && [item subtitleFetcher]) {
        fetcher = [item subtitleFetcher];
    } else if ([item respondsToSelector:@selector(subtitleURL)]) {
        if ([item subtitleURL]) {
            BBCSMPNetworkSubtitleFetcher* networkFetcher = [[BBCSMPNetworkSubtitleFetcher alloc] initWithURL:[item subtitleURL]];
            fetcher = networkFetcher;
        }
    }
    return fetcher;
}

@end
