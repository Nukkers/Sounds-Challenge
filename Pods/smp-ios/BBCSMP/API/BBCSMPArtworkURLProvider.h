//
//  BBCSMPArtworkURLProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@protocol BBCSMPArtworkURLProvider <NSObject>

- (NSURL*)URLForArtworkAtSize:(CGSize)size scale:(CGFloat)scale;

@end
