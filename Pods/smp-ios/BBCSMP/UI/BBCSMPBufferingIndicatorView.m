//
//  BBCSMPBufferingIndicatorView.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPBufferingIndicatorView.h"

@interface BBCSMPBufferingIndicatorView ()

@property (nonatomic, assign) BOOL animating;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicatorView;

@end

@implementation BBCSMPBufferingIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setBrand:(BBCSMPBrand*)brand
{
    [_activityIndicatorView setColor:[brand highlightColor]];
}

- (void)commonInit
{
    [self setUserInteractionEnabled:NO];
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activityIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    _activityIndicatorView.center = self.center;
    [_activityIndicatorView setHidesWhenStopped:YES];
    [self addSubview:_activityIndicatorView];
}

- (void)setAnimating:(BOOL)animating
{
    if (_animating == animating)
        return;

    _animating = animating;
    if (_animating) {
        [_activityIndicatorView startAnimating];
    } else {
        [_activityIndicatorView stopAnimating];
    }
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    if (hidden) {
        [self setAnimating:NO];
    } else {
        [self setAnimating:YES];
    }
}

- (void)willMoveToSuperview:(UIView*)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self setAnimating:YES];
    } else {
        [self setAnimating:NO];
    }
}

#pragma mark BBCSMPBufferingIndicatorScene

- (void)appear
{
    self.hidden = NO;
}

- (void)disappear
{
    self.hidden = YES;
}

@end
