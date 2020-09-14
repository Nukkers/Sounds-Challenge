//
//  BBCSMPNetworkArtworkFetcher.h
//  BBCMediaPlayer
//
//  Created by Stuart Sharpe on 04/08/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPArtworkURLProvider.h"

@protocol BBCHTTPClient;

@interface BBCSMPNetworkArtworkFetcher : NSObject <BBCSMPArtworkFetcher>

- (instancetype)initWithHTTPClient:(id<BBCHTTPClient>)httpClient;

@property (nonatomic, strong) id<BBCSMPArtworkURLProvider> artworkURLProvider;

@end
