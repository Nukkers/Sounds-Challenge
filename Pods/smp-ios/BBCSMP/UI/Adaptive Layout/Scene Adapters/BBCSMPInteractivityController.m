//
//  BBCSMPInteractivityController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPInteractivityController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPInteractivityController {
    UIButton *_interactivityButton;
}

#pragma mark Initialization

- (instancetype)initWithInteractivityButton:(UIButton *)interactivityButton
{
    self = [super init];
    if(self) {
        _interactivityButton = interactivityButton;
        [interactivityButton addTarget:self
                                action:@selector(handleButtonTapInside)
                      forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)handleButtonTapInside
{
    [_activitySceneDelegate activitySceneDidReceiveInteraction:self];
}

#pragma mark BBCSMPInteractivityController

@synthesize activitySceneDelegate = _activitySceneDelegate;

- (void)setActivitySceneAccessibilityLabel:(NSString *)accessibilityLabel
{
    _interactivityButton.accessibilityLabel = accessibilityLabel;
}

- (void)setActivitySceneAccessibilityHint:(NSString *)accessibilityHint
{
    _interactivityButton.accessibilityHint = accessibilityHint;
}

@end
