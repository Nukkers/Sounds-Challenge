//
//  BBCSMPLiveIndicator.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 18/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPLiveIndicator.h"
#import "UIColor+SMPPalette.h"

@implementation BBCSMPLiveIndicator {
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.isAccessibilityElement = YES;
    self.backgroundColor = [UIColor SMPWhiteColor];
    self.clearsContextBeforeDrawing = YES;
    self.opaque = NO;
    
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont boldSystemFontOfSize:15.0f];
    _label.text = @"LIVE";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor SMPBlackColor];
    [self addSubview:_label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.bounds;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(35.0, 20.0);
}

#pragma mark BBCSMPLiveIndicatorScene

- (void)showLiveLabel
{
    self.hidden = NO;
}

- (void)hideLiveLabel
{
    self.hidden = YES;
}

- (void)setLiveIndicatorAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

@end
