//
//  BBCSMPLiveIndicatorController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPLiveIndicatorController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPLiveIndicatorController {
    UIView *_liveIndicator;
}

#pragma mark Initialization

- (instancetype)initWithLiveIndicator:(UIView *)liveIndicator
{
    self = [super init];
    if(self) {
        _liveIndicator = liveIndicator;
    }

    return self;
}

#pragma mark BBCSMPLiveIndicatorScene

- (void)showLiveLabel
{
    _liveIndicator.hidden = NO;
}

- (void)hideLiveLabel
{
    _liveIndicator.hidden = YES;
}

- (void)setLiveIndicatorAccessibilityLabel:(NSString *)accessibilityLabel
{
    
}

@end
