//
//  BBCSMPUISwitchControlsStateProviding.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/07/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUISwitchControlsStateProviding.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPUISwitchControlsStateProviding

- (BOOL)isSwitchControlsRunning
{
    return UIAccessibilityIsSwitchControlRunning();
}

@end
