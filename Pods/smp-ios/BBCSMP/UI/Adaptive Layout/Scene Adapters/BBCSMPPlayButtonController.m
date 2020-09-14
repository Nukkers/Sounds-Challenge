//
//  BBCSMPPlayButtonController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlayButtonController.h"
#import "BBCSMPIconButton.h"
#import "BBCSMPIcon.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPPlayButtonController {
    BBCSMPIconButton *_playButton;
    id<BBCSMPIcon> _playIcon;
}

#pragma mark Initialization

- (instancetype)initWithPlayButton:(BBCSMPIconButton *)playButton
             iconMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)iconMeasurementPolicy
{
    self = [super init];
    if(self) {
        _playButton = playButton;
        _playButton.measurementPolicy = iconMeasurementPolicy;
        
        [playButton addTarget:self
                       action:@selector(playButtonTapped)
             forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)playButtonTapped
{
    [_playButtonDelegate playButtonSceneDidReceiveTap:self];
}

#pragma mark BBCSMPPlayButtonScene

@synthesize playButtonDelegate = _playButtonDelegate;

- (void)showPlayButton
{
    _playButton.hidden = NO;
}

- (void)hidePlayButton
{
    _playButton.hidden = YES;
}

- (void)setPlayButtonIcon:(id<BBCSMPIcon>)icon
{
    _playButton.icon = icon;
}

- (void)setPlayButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _playButton.accessibilityLabel = accessibilityLabel;
}

- (void)setPlayButtonHighlightColor:(UIColor *)highlightColor
{
    
}

- (void)setPlaybuttonAccessibilityHint:(NSString *)accessibilityHint
{
    _playButton.accessibilityHint = accessibilityHint;
}

@end
