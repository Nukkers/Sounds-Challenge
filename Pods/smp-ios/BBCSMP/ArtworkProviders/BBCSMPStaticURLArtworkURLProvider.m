//
//  BBCSMPStaticURLArtworkURLProvider.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPStaticURLArtworkURLProvider.h"

@interface BBCSMPStaticURLArtworkURLProvider ()

@property (nonatomic, copy) NSString* URL;

@end

@implementation BBCSMPStaticURLArtworkURLProvider

- (instancetype)initWithURL:(NSString*)URL
{
    if ((self = [super init])) {
        _URL = URL;
    }
    return self;
}

- (NSURL*)URLForArtworkAtSize:(CGSize)size scale:(CGFloat)scale
{
    return [NSURL URLWithString:_URL];
}

@end
