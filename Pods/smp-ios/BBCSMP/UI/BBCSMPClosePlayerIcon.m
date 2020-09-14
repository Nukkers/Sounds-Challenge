//
//  BBCSMPClosePlayerIcon.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 06/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPClosePlayerIcon.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPClosePlayerIcon

@synthesize colour;

- (void)drawInFrame:(CGRect)frame
{
    CGRect iconFrame = CGRectMake(13, 13, 19, 19);
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 2, CGRectGetMinY(iconFrame) + 2)];
    [bezierPath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 20, CGRectGetMinY(iconFrame) + 20) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 20, CGRectGetMinY(iconFrame) + 20) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 20, CGRectGetMinY(iconFrame) + 20)];
    bezierPath.lineCapStyle = kCGLineCapSquare;
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    
    [[self colour] setStroke];
    bezierPath.lineWidth = 3;
    [bezierPath stroke];
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 20, CGRectGetMinY(iconFrame) + 2)];
    [bezier2Path addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 2, CGRectGetMinY(iconFrame) + 20) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 2, CGRectGetMinY(iconFrame) + 20) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 2, CGRectGetMinY(iconFrame) + 20)];
    bezier2Path.lineCapStyle = kCGLineCapSquare;
    bezier2Path.lineJoinStyle = kCGLineJoinBevel;
    
    [[self colour] setStroke];
    bezier2Path.lineWidth = 3;
    [bezier2Path stroke];
}

@end
