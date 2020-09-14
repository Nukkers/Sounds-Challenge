//
//  BBCSMPBufferingIndicatorController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPBufferingIndicatorController.h"
#import <UIKit/UIActivityIndicatorView.h>

@implementation BBCSMPBufferingIndicatorController {
    UIActivityIndicatorView *_bufferingActivityIndicator;
}

#pragma mark Initialization

- (instancetype)initWithBufferingActivityIndicator:(UIActivityIndicatorView *)bufferingActivityIndicator
{
    self = [super init];
    if(self) {
        _bufferingActivityIndicator = bufferingActivityIndicator;
    }
    
    return self;
}

#pragma mark BBCSMPBufferingIndicatorScene

- (void)appear
{
    _bufferingActivityIndicator.hidden = NO;
}

- (void)disappear
{
    _bufferingActivityIndicator.hidden = YES;
}

@end
