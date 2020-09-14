//
//  BBCSMPIconButton.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 01/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPIconButton.h"
#import "BBCSMPIcon.h"
#import "BBCSMPMeasurementPolicy.h"

@implementation BBCSMPIconButton

#pragma mark Overrides

- (void)setIcon:(id<BBCSMPIcon>)icon
{
    _icon = icon;
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect frame = rect;
    if (_measurementPolicy) {
        frame = [_measurementPolicy preferredBoundsForDrawingInRect:rect];
    }

    [_icon drawInFrame:frame];
}

@end
