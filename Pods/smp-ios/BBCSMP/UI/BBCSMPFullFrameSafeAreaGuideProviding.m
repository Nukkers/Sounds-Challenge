//
//  BBCSMPFullFrameSafeAreaGuideProviding.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPFullFrameSafeAreaGuideProviding.h"
#import <UIKit/UIView.h>

@implementation BBCSMPFullFrameSafeAreaGuideProviding {
    __weak UIView *_view;
    UIEdgeInsets _titleBarEdgeInsets;
}

#pragma mark Initialization

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if(self) {
        _view = view;
        _titleBarEdgeInsets = UIEdgeInsetsMake(20.0, 0, 0, 0);
    }
    
    return self;
}

#pragma mark BBCSMPSafeAreaGuideProviding

- (CGRect)safeAreaGuideFrame
{
    return _view.bounds;
}

- (UIEdgeInsets)titleBarContentInsets
{
    return _titleBarEdgeInsets;
}

@end
