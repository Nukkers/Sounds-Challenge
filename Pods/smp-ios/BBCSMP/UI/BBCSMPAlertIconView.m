//
//  BBCSMPAlertIconView.m
//  BBCSMP
//
//  Created by Al Priest on 20/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAlertIconView.h"
#import "BBCSMPAlertIcon.h"
#import "BBCSMPIconFactory.h"
#import "UIColor+SMPPalette.h"

@implementation BBCSMPAlertIconView

- (void)drawRect:(CGRect)rect
{
    BBCSMPAlertIcon* iconDrawer = [[BBCSMPAlertIcon alloc] init];

    [iconDrawer setColour:[UIColor SMPWhiteColor]];
    [iconDrawer setExclamationMarkColour:[UIColor SMPStormColor]];
    [iconDrawer drawInFrame:rect];
}

@end
