//
//  BBCSMPStopButtonController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPStopButtonController.h"
#import "BBCSMPIconButton.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPStopButtonController {
    BBCSMPIconButton *_stopButton;
}

#pragma mark Initialization

- (instancetype)initWithStopButton:(BBCSMPIconButton *)stopButton
             iconMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)iconMeasurementPolicy
{
    self = [super init];
    if(self) {
        _stopButton = stopButton;
        _stopButton.measurementPolicy = iconMeasurementPolicy;
        
        [stopButton addTarget:self
                       action:@selector(stopButtonTapped)
             forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)stopButtonTapped
{
    [_stopButtonDelegate stopButtonDidReceiveTap:self];
}

#pragma mark BBCSMPStopButtonScene

@synthesize stopButtonDelegate = _stopButtonDelegate;

- (void)showStopButton
{
    _stopButton.hidden = NO;
}

- (void)hideStopButton
{
    _stopButton.hidden = YES;
}

- (void)setStopButtonIcon:(id<BBCSMPIcon>)icon
{
    _stopButton.icon = icon;
}

- (void)setStopButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    _stopButton.accessibilityLabel = accessibilityLabel;
}

- (void)setStopButtonAccessibilityHint:(NSString *)accessibilityHint
{
    _stopButton.accessibilityHint = accessibilityHint;
}

@end
