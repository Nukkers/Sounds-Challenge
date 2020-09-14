//
//  BBCSMPArtworkFetcher.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPArtworkURLProvider.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ArtworkFetchSuccess)(UIImage* artworkImage);
typedef void (^ArtworkFetchFailure)(NSError* artworkError);

@protocol BBCSMPArtworkFetcher <NSObject>
- (void)fetchArtworkImageAtSize:(CGSize)size scale:(CGFloat)scale success:(ArtworkFetchSuccess)success failure:(ArtworkFetchFailure)failure;

@end

NS_ASSUME_NONNULL_END
