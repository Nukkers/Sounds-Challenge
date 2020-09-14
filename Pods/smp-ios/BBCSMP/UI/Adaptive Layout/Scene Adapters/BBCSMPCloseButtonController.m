//
//  BBCSMPCloseButtonController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPCloseButtonController.h"
#import "BBCSMPIconButton.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPCloseButtonController {
    BBCSMPIconButton *_closeButton;
}

#pragma mark Initialization

- (instancetype)initWithCloseButton:(BBCSMPIconButton *)closeButton
              iconMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)iconMeasurementPolicy
{
    self = [super init];
    if(self) {
        _closeButton = closeButton;
        _closeButton.measurementPolicy = iconMeasurementPolicy;
        
        [closeButton addTarget:self
                        action:@selector(closeButtonTapped)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)closeButtonTapped
{
    [_closeButtonDelegate closeButtonSceneDidTapClose:self];
}

#pragma mark BBCSMPCloseButtonScene

@synthesize closeButtonDelegate = _closeButtonDelegate;

- (void)hide
{
    _closeButton.hidden = YES;
}

- (void)show
{
    _closeButton.hidden = NO;
}

- (void)setCloseButtonIcon:(id<BBCSMPIcon>)icon
{
    _closeButton.icon = icon;
}

- (void)setCloseButtonAccessibilityLabel:(NSString *)accessibilityLabel
{
    
}

- (void)setCloseButtonAccessibilityHint:(NSString *)accessibilityHint
{
    
}

@end
