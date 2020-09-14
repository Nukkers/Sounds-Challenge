//
//  BBCSMPLeaveFullscreenIcon.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 23/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPLeaveFullscreenIcon.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPLeaveFullscreenIcon

- (void)drawInFrame:(CGRect)iconFrame
{
    UIBezierPath* squarePath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame), 22, 22)];
    [self.colour setStroke];
    squarePath.lineWidth = 1;
    [squarePath stroke];

    UIBezierPath* arrow1Path = [UIBezierPath bezierPath];
    [arrow1Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 7, CGRectGetMinY(iconFrame) + 7)];
    [arrow1Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 1, CGRectGetMinY(iconFrame) + 7)];
    [arrow1Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 7, CGRectGetMinY(iconFrame) + 1)];
    [arrow1Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 7, CGRectGetMinY(iconFrame) + 7)];
    [arrow1Path closePath];
    [self.colour setFill];
    [arrow1Path fill];

    UIBezierPath* arrow2Path = [UIBezierPath bezierPath];
    [arrow2Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15, CGRectGetMinY(iconFrame) + 7)];
    [arrow2Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 21, CGRectGetMinY(iconFrame) + 7)];
    [arrow2Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15, CGRectGetMinY(iconFrame) + 1)];
    [arrow2Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15, CGRectGetMinY(iconFrame) + 7)];
    [arrow2Path closePath];
    [self.colour setFill];
    [arrow2Path fill];

    UIBezierPath* arrow3Path = [UIBezierPath bezierPath];
    [arrow3Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15, CGRectGetMinY(iconFrame) + 15)];
    [arrow3Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 21, CGRectGetMinY(iconFrame) + 15)];
    [arrow3Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15, CGRectGetMinY(iconFrame) + 21)];
    [arrow3Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15, CGRectGetMinY(iconFrame) + 15)];
    [arrow3Path closePath];
    [self.colour setFill];
    [arrow3Path fill];

    UIBezierPath* arrow4Path = [UIBezierPath bezierPath];
    [arrow4Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 7, CGRectGetMinY(iconFrame) + 15)];
    [arrow4Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 1, CGRectGetMinY(iconFrame) + 15)];
    [arrow4Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 7, CGRectGetMinY(iconFrame) + 21)];
    [arrow4Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 7, CGRectGetMinY(iconFrame) + 15)];
    [arrow4Path closePath];
    [self.colour setFill];
    [arrow4Path fill];
}

@end
