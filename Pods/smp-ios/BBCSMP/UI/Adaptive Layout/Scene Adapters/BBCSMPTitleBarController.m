//
//  BBCSMPTitleBarController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTitleBarController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPTitleBarController {
    UIView *_titleBarContainer;
}

#pragma mark Initialization

- (instancetype)initWithTitleBarContainer:(UIView *)titleBarContainer
{
    self = [super init];
    if(self) {
        _titleBarContainer = titleBarContainer;
    }
    
    return self;
}

#pragma mark BBCSMPTitleBarScene

- (void)show
{
    _titleBarContainer.hidden = NO;
}

- (void)hide
{
    _titleBarContainer.hidden = YES;
}

@end
