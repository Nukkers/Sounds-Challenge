//
//  BBCSMPColorFunctions.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#ifndef BBCSMP_COLOR_FUNCTIONS
#define BBCSMP_COLOR_FUNCTIONS

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_INLINE
UIColor * BBCSMPColorFromRGB(int rgbValue)
{
    CGFloat red = ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0;
    CGFloat green = ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0;
    CGFloat blue = ((CGFloat)(rgbValue & 0xFF)) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#endif
