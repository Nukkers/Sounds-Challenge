//
//  BBCSMPAirplayButtonController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAirplayButtonController.h"
#import <MediaPlayer/MPVolumeView.h>

@implementation BBCSMPAirplayButtonController {
    MPVolumeView *_airplayButton;
}

#pragma mark Initialization

- (instancetype)initWithAirplayButton:(MPVolumeView *)airplayButton
{
    self = [super init];
    if(self) {
        _airplayButton = airplayButton;
        airplayButton.showsVolumeSlider = NO;
        
        [self disableTouchHighlightingForAirplayButton];
    }
    
    return self;
}

#pragma mark BBCSMPAirplayButtonScene

- (void)showAirplayButton
{
    _airplayButton.hidden = NO;
}

- (void)hideAirplayButton
{
    _airplayButton.hidden = YES;
}

#pragma mark Private

- (void)disableTouchHighlightingForAirplayButton
{
    for(UIView *subview in _airplayButton.subviews) {
        UIButton *button = (UIButton *)subview;
        if([button isKindOfClass:[UIButton class]]) {
            button.showsTouchWhenHighlighted = NO;
        }
    }
}

@end
