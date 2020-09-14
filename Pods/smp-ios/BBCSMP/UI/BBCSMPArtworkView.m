//
//  BBCSMPArtworkView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPArtworkView.h"
#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPNetworkArtworkFetcher.h"

@implementation BBCSMPArtworkView

#pragma mark Overrides

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.layoutListener frameDidChange:self.frame];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_delegate contentPlaceholderSceneSizeDidChange:self];
}

#pragma mark BBCSMPContentPlaceholderScene

@synthesize delegate = _delegate;

- (CGSize)placeholderSize
{
    return self.frame.size;
}

- (void)appear
{
    self.hidden = NO;
}

- (void)disappear
{
    self.hidden = YES;
}

- (void)showPlaceholderImage:(UIImage *)image
{
    self.image = image;
}

#pragma mark Private

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.contentMode = UIViewContentModeScaleAspectFit;
}

@end
