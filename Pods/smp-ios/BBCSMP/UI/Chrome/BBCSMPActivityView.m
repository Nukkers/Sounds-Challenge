//
//  BBCSMPActivityView.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPActivityView.h"

@implementation BBCSMPActivityView

#pragma mark Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp
{
    [self addTarget:self action:@selector(handleTap:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Target Action

- (void)handleTap:(__unused id)sender
{
    [_activitySceneDelegate activitySceneDidReceiveInteraction:self];
}

#pragma mark Accessibility

- (UIAccessibilityTraits)accessibilityTraits
{
    return UIAccessibilityTraitNone;
}

#pragma mark BBCSMPActivityScene

- (void)setActivitySceneAccessibilityLabel:(NSString *)accessibilityLabel
{
    self.accessibilityLabel = accessibilityLabel;
}

- (void)setActivitySceneAccessibilityHint:(NSString *)accessibilityHint
{
    self.accessibilityHint = accessibilityHint;
}

@end
