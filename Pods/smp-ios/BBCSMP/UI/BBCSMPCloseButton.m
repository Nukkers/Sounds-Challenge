//
//  BBCSMPCloseButton.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 08/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPCloseButton.h"
#import "BBCSMPLeaveFullscreenIcon.h"

@implementation BBCSMPCloseButton

#pragma mark Initialization

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    [super addTarget:self action:@selector(handleTouch:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Class Methods

+ (instancetype)closeButton
{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

#pragma mark Overrides

- (NSString*)accessibilityIdentifier
{
    return @"smp_close_button";
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(44.0, 44.0);
}

- (UIColor*)iconBackgroundColor
{
    return self.backgroundColor;
}

#pragma mark BBCSMPCloseButtonScene

@synthesize closeButtonDelegate = _closeButtonDelegate;

- (void)show
{
    self.hidden = NO;
}

- (void)hide
{
    self.hidden = YES;
}

- (void)setCloseButtonIcon:(id<BBCSMPIcon>)icon
{
    super.icon = icon;
}

- (void)setCloseButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

- (void)setCloseButtonAccessibilityHint:(NSString *)accessibilityHint
{
    self.accessibilityHint = accessibilityHint;
}

#pragma mark Target Action

- (void)handleTouch:(__unused id)sender
{
    [_closeButtonDelegate closeButtonSceneDidTapClose:self];
}

@end
