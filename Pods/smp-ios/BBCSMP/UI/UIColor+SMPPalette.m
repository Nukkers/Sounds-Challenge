//
//  UIColor+SMPPalette.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "UIColor+SMPPalette.h"
#import "BBCSMPColorFunctions.h"

@implementation UIColor (SMPPalette)

+ (UIColor*)SMPWhiteColor
{
    return BBCSMPColorFromRGB(0xFFFFFF);
}

+ (UIColor*)SMPLighterStoneColor
{
    return BBCSMPColorFromRGB(0xF7F7F7);
}

+ (UIColor*)SMPStoneColor
{
    return BBCSMPColorFromRGB(0xB3B3B3);
}

+ (UIColor*)SMPFlintColor
{
    return BBCSMPColorFromRGB(0x7F7F7F);
}

+ (UIColor*)SMPStormColor
{
    return BBCSMPColorFromRGB(0x333333);
}

+ (UIColor*)SMPBarlesqueBlackColor
{
    return BBCSMPColorFromRGB(0x191919);
}

+ (UIColor*)SMPBlackColor
{
    return BBCSMPColorFromRGB(0x000000);
}

+ (UIColor*)SMPStormTranslucentColor
{
    return [[[self class] SMPStormColor] colorWithAlphaComponent:0.8f];
}

+ (UIColor*)SMPNightTranslucentColor
{
    return [[[self class] SMPBarlesqueBlackColor] colorWithAlphaComponent:0.8f];
}

@end
