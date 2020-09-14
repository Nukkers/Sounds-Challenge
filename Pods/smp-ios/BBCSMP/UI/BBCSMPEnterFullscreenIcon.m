//
//  BBCSMPEnterFullscreenIcon.m
//  BBCSMP
//
//  Created by Richard Gilpin on 05/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPEnterFullscreenIcon.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPEnterFullscreenIcon

@synthesize colour;

- (void)drawInFrame:(CGRect)frame
{
    CGRect iconFrame = CGRectMake(11, 11, 22, 22);
    
    UIBezierPath* squarePath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(iconFrame) + 6.5, CGRectGetMinY(iconFrame) + 6.5, 9, 9)];
    [self.colour setStroke];
    squarePath.lineWidth = 1;
    [squarePath stroke];
    
    UIBezierPath* arrow1Path = [UIBezierPath bezierPath];
    [arrow1Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame))];
    [arrow1Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 6, CGRectGetMinY(iconFrame))];
    [arrow1Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame) + 6)];
    [arrow1Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame))];
    [arrow1Path closePath];
    [self.colour setFill];
    [arrow1Path fill];
    
    UIBezierPath* arrow2Path = [UIBezierPath bezierPath];
    [arrow2Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 22, CGRectGetMinY(iconFrame))];
    [arrow2Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 16, CGRectGetMinY(iconFrame))];
    [arrow2Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 22, CGRectGetMinY(iconFrame) + 6)];
    [arrow2Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 22, CGRectGetMinY(iconFrame))];
    [arrow2Path closePath];
    [self.colour setFill];
    [arrow2Path fill];
    
    UIBezierPath* arrow3Path = [UIBezierPath bezierPath];
    [arrow3Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 22, CGRectGetMinY(iconFrame) + 22)];
    [arrow3Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 16, CGRectGetMinY(iconFrame) + 22)];
    [arrow3Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 22, CGRectGetMinY(iconFrame) + 16)];
    [arrow3Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 22, CGRectGetMinY(iconFrame) + 22)];
    [arrow3Path closePath];
    [self.colour setFill];
    [arrow3Path fill];
    
    UIBezierPath* arrow4Path = [UIBezierPath bezierPath];
    [arrow4Path moveToPoint:CGPointMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame) + 22)];
    [arrow4Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 6, CGRectGetMinY(iconFrame) + 22)];
    [arrow4Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame) + 16)];
    [arrow4Path addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame) + 22)];
    [arrow4Path closePath];
    [self.colour setFill];
    [arrow4Path fill];
}

@end
