//
//  BBCSMPLayoutGuideSafeAreaGuideProviding.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPLayoutGuideSafeAreaGuideProviding.h"
#import <UIKit/UIView.h>

@implementation BBCSMPLayoutGuideSafeAreaGuideProviding {
    __weak UIView *_view;
}

#pragma mark Initialization

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if(self) {
        _view = view;
    }
    
    return self;
}

#pragma mark BBCSMPSafeAreaGuideProviding

- (CGRect)safeAreaGuideFrame
{
    return _view.safeAreaLayoutGuide.layoutFrame;
}

- (UIEdgeInsets)titleBarContentInsets
{
    return UIEdgeInsetsMake(0, 0, 20.0, 0);
}

@end
