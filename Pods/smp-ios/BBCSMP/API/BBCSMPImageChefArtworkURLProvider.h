//
//  BBCSMPImageChefArtworkURLProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPArtworkURLProvider.h"

extern NSString* const BBCSMPImageChefArtworkURLProviderDefaultRecipeToken;

@interface BBCSMPImageChefArtworkURLProvider : NSObject <BBCSMPArtworkURLProvider>

@property (nonatomic, copy, readonly) NSString* recipeURL;
@property (nonatomic, copy, readonly) NSString* recipeToken;

- (instancetype)initWithRecipeURL:(NSString*)recipeURL NS_SWIFT_NAME(init(recipeUrl:));
- (instancetype)initWithRecipeURL:(NSString*)recipeURL recipeToken:(NSString*)recipeToken NS_SWIFT_NAME(init(recipeUrl:recipeToken:));

@end
