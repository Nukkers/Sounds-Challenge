//
//  BBCSMPPlayCallToActionController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlayCallToActionController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPPlayCallToActionController {
    UIButton *_callToActionButton;
    UILabel *_durationLabel;
}

#pragma mark Initialization

- (instancetype)initWithCallToActionButton:(UIButton *)callToActionButton
                             durationLabel:(UILabel *)durationLabel
{
    self = [super init];
    if(self) {
        _callToActionButton = callToActionButton;
        _durationLabel = durationLabel;
        
        [callToActionButton addTarget:self
                               action:@selector(callToActionButtonTapped)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark Private

- (void)callToActionButtonTapped
{
    [_delegate callToActionSceneDidReceiveTap:self];
}

#pragma mark BBCSMPPlayCTAButtonScene

@synthesize delegate = _delegate;

- (void)appear
{
    _callToActionButton.hidden = NO;
}

- (void)disappear
{
    _callToActionButton.hidden = YES;
}

- (void)hideDuration
{
    _durationLabel.hidden = YES;
}

- (void)showDuration
{
    _durationLabel.hidden = NO;
}

- (void)setFormattedDurationString:(NSString *)formattedDuration
{
    _durationLabel.text = formattedDuration;
}

- (void)setPlayCallToActionAccessibilityLabel:(NSString *)accessibilityLabel
{
    
}

- (void)setPlayCallToActionAccessibilityHint:(NSString *)accessibilityHint
{
    
}

// TODO: Remove
- (void)showDurationWithDuration:(BBCSMPDuration *)duration { }
- (void)setAvType:(BBCSMPAVType)avType { }

@end
