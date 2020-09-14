//
//  BBCSMPPauseButtonController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPauseButtonController.h"
#import "BBCSMPIconButton.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPPauseButtonController {
    BBCSMPIconButton *_pauseButton;
}

#pragma mark Initialization

- (instancetype)initWithPauseButton:(BBCSMPIconButton *)pauseButton
              iconMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)iconMeasurementPolicy
{
    self = [super init];
    if(self) {
        _pauseButton = pauseButton;
        _pauseButton.measurementPolicy = iconMeasurementPolicy;
        
        [pauseButton addTarget:self
                        action:@selector(pauseButtonTapped)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)pauseButtonTapped
{
    [_pauseButtonDelegate pauseButtonSceneDidReceiveTap:self];
}

#pragma mark BBCSMPPauseButtonScene

@synthesize pauseButtonDelegate = _pauseButtonDelegate;

- (void)showPauseButton
{
    _pauseButton.hidden = NO;
}

- (void)hidePauseButton
{
    _pauseButton.hidden = YES;
}

- (void)setPauseButtonIcon:(id<BBCSMPIcon>)icon
{
    _pauseButton.icon = icon;
}

- (void)setPauseButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _pauseButton.accessibilityLabel = accessibilityLabel;
}

- (void)setPauseButtonAccessibilityHint:(NSString *)accessibilityHint
{
    _pauseButton.accessibilityHint = accessibilityHint;
}

@end
