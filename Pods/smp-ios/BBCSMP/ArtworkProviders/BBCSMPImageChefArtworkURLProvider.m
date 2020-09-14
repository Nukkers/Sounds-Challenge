//
//  BBCSMPImageChefArtworkURLProvider.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPImageChefArtworkURLProvider.h"

@interface BBCSMPImageChefArtworkURLProvider ()

@property (nonatomic, copy, readwrite) NSString* recipeURL;
@property (nonatomic, copy, readwrite) NSString* recipeToken;

@end

@implementation BBCSMPImageChefArtworkURLProvider

NSString* const BBCSMPImageChefArtworkURLProviderDefaultRecipeToken = @"{recipe}";

- (instancetype)initWithRecipeURL:(NSString*)recipeURL recipeToken:(NSString*)recipeToken
{
    if ((self = [super init])) {
        _recipeURL = recipeURL;
        _recipeToken = recipeToken;
    }
    return self;
}

- (instancetype)initWithRecipeURL:(NSString*)recipeURL
{
    return [self initWithRecipeURL:recipeURL recipeToken:BBCSMPImageChefArtworkURLProviderDefaultRecipeToken];
}

- (NSURL*)URLForArtworkAtSize:(CGSize)size scale:(CGFloat)scale
{
    CGSize scaledSize = CGSizeMake(size.width * scale, size.height * scale);
    CGSize sizeAtCorrectAspectRatio;
    if (scaledSize.height == scaledSize.width) {
        // Square image - that's OK
        sizeAtCorrectAspectRatio = scaledSize;
    } else {
        // Otherwise, assume the aspect ratio should be 16:9 and base it on either the height or the width
        CGFloat widthAtClosestMultipleOfSixteenThatFits = 16.0f * floorf(scaledSize.width / 16.0f);
        CGFloat heightBasedOnWidth = 9.0f * widthAtClosestMultipleOfSixteenThatFits / 16.0f;
        if (heightBasedOnWidth > scaledSize.height) {
            CGFloat heightAtClosestMultipleOfNineThatFits = 9.0f * floorf(scaledSize.height / 9.0f);
            CGFloat widthBasedOnHeight = 16.0f * heightAtClosestMultipleOfNineThatFits / 9.0f;
            sizeAtCorrectAspectRatio = CGSizeMake(widthBasedOnHeight, heightAtClosestMultipleOfNineThatFits);
        } else {
            sizeAtCorrectAspectRatio = CGSizeMake(widthAtClosestMultipleOfSixteenThatFits, heightBasedOnWidth);
        }
    }
    NSString* sizeString = [NSString stringWithFormat:@"%.0fx%.0f", sizeAtCorrectAspectRatio.width, sizeAtCorrectAspectRatio.height];
    return [NSURL URLWithString:[_recipeURL stringByReplacingOccurrencesOfString:_recipeToken withString:sizeString]];
}

@end
