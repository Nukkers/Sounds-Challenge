//
//  BBCSMPUIVoiceoverStateProviding.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUIVoiceoverStateProviding.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPUIVoiceoverStateProviding

- (BOOL)isVoiceoverRunning
{
    return UIAccessibilityIsVoiceOverRunning();
}

@end
