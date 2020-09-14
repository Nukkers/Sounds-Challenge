//
//  BBCSMPImageChefArtworkFetcher.m
//  BBCSMP
//
//  Created by Matthew Mould on 07/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPClient.h>
#import "BBCSMPImageChefArtworkFetcher.h"
#import "BBCSMPImageChefArtworkURLProvider.h"
#import "BBCSMPNetworkArtworkFetcher.h"

@interface BBCSMPImageChefArtworkFetcher ()
@property (nonatomic, strong) id<BBCSMPArtworkFetcher> artworkFetcher;
@property (nonatomic, strong) id<BBCSMPArtworkURLProvider> artworkURLProvider;
@property (nonatomic, strong) BBCSMPNetworkArtworkFetcher* bbcSMPNetworkArtworkFetcher;

@end

@implementation BBCSMPImageChefArtworkFetcher

- (instancetype)initWithRecipeURL:(NSString*)recipeUrl withHTTPClient:(id<BBCHTTPClient>)bbcHTTPClient;
{
    self = [super init];
    if (self) {
        self.bbcSMPNetworkArtworkFetcher = [[BBCSMPNetworkArtworkFetcher alloc] initWithHTTPClient:bbcHTTPClient];
        self.bbcSMPNetworkArtworkFetcher.artworkURLProvider = [[BBCSMPImageChefArtworkURLProvider alloc] initWithRecipeURL:recipeUrl];
    }
    return self;
}

- (instancetype)initWithRecipeURL:(NSString*)recipeUrl withRecipeToken:(NSString*)recipeToken withHTTPClient:(id<BBCHTTPClient>)bbcHTTPClient
{
    self = [super init];
    if (self) {
        self.bbcSMPNetworkArtworkFetcher = [[BBCSMPNetworkArtworkFetcher alloc] initWithHTTPClient:bbcHTTPClient];
        self.bbcSMPNetworkArtworkFetcher.artworkURLProvider = [[BBCSMPImageChefArtworkURLProvider alloc] initWithRecipeURL:recipeUrl recipeToken:recipeToken];
    }
    return self;
}

- (void)fetchArtworkImageAtSize:(CGSize)size scale:(CGFloat)scale success:(ArtworkFetchSuccess)success failure:(ArtworkFetchFailure)failure
{
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        [self.bbcSMPNetworkArtworkFetcher fetchArtworkImageAtSize:size
                                                            scale:scale
                                                          success:success
                                                          failure:failure];
    }
}

@end
