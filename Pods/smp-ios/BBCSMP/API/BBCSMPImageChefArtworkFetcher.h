//
//  BBCSMPImageChefArtworkFetcher.h
//  BBCSMP
//
//  Created by Matthew Mould on 07/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPArtworkURLProvider.h"

@protocol BBCHTTPClient;

@interface BBCSMPImageChefArtworkFetcher : NSObject <BBCSMPArtworkFetcher>

- (instancetype)initWithRecipeURL:(NSString*)recipeUrl withHTTPClient:(id<BBCHTTPClient>)bbcHTTPClient;
- (instancetype)initWithRecipeURL:(NSString*)recipeUrl withRecipeToken:(NSString*)recipeToken withHTTPClient:(id<BBCHTTPClient>)bbcHTTPClient;

@end
