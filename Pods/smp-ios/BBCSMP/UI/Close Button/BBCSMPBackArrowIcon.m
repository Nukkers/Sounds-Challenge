//
//  BBCSMPBackArrowIcon.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 14/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPBackArrowIcon.h"
#import <UIKit/UIBezierPath.h>

@implementation BBCSMPBackArrowIcon

@synthesize colour;

- (void)drawInFrame:(CGRect)frame
{
    CGFloat arrowWidth = 11.0;
    CGFloat arrowHeight = 21.0;
    CGFloat halfWidth = CGRectGetMidX(frame);
    CGFloat halfHeight = CGRectGetMidY(frame);
    
    [colour setStroke];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinBevel;
    path.lineWidth = 3.33;
    
    [path moveToPoint:CGPointMake(halfWidth + arrowWidth / 2.0, halfHeight - arrowHeight / 2.0)];
    [path addLineToPoint:CGPointMake(halfWidth - arrowWidth / 2.0, halfHeight)];
    [path addLineToPoint:CGPointMake(halfWidth + arrowWidth / 2.0, halfHeight + arrowHeight / 2.0)];
    [path stroke];
}

@end
