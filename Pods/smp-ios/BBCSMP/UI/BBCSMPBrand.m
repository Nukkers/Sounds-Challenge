//
//  BBCSMPBrand.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPBrand.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPBrandingIcons.h"
#import "UIColor+SMPPalette.h"
#import "BBCSMPColorFunctions.h"

@implementation BBCSMPBrand

#pragma mark Overrides

- (instancetype)init
{
    self = [super init];
    if (self) {
        _icons = [BBCSMPBrandingIcons new];
        _highlightColor = BBCSMPColorFromRGB(0x188efb);
        _focusedHighlightColor = BBCSMPColorFromRGB(0x145cc0);
        _foregroundColor = [UIColor SMPWhiteColor];
        _selectedForegroundColor = [UIColor SMPWhiteColor];
        _accessibilityIndex = [BBCSMPAccessibilityIndex new];
    }

    return self;
}

@end
