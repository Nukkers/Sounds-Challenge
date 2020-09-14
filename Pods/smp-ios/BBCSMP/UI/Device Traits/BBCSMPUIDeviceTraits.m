//
//  BBCSMPUIDeviceTraits.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUIDeviceTraits.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPUIDeviceTraits

- (CGFloat)scale
{
    return [[UIScreen mainScreen] scale];
}

- (BOOL)homeIndicatorAvailable
{
    if (@available(iOS 11.0, *)) {
        return YES;
    }
    else {
        return NO;
    }
}

@end
