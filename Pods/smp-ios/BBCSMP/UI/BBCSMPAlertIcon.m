//
//  BBCSMPAlertIcon.m
//  BBCSMP
//
//  Created by Al Priest on 20/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAlertIcon.h"
#import "BBCSMPIcon.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPAlertIcon

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colour = [UIColor whiteColor];
        _exclamationMarkColour = [UIColor blackColor];
    }

    return self;
}

#pragma mark Icon Drawing

- (void)drawInFrame:(CGRect)frame
{
    CGFloat width = CGRectGetWidth(frame), height = CGRectGetHeight(frame);
    CGFloat center = width / 2.0;

    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(center, 0.0)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0.0, height)];
    [path addLineToPoint:CGPointMake(center, 0.0)];
    [path closePath];

    [self.colour setFill];
    [path fill];

    [self drawExclamationMark:center];
}

- (void)drawExclamationMark:(CGFloat)center
{
    CGFloat x = 7.0;

    CGFloat width = 3.0;
    CGFloat height = 8.0;

    CGFloat spacing = 1.5;

    [self.exclamationMarkColour setFill];
    UIRectFill(CGRectMake(center - (width / 2), x, width, height));
    UIRectFill(CGRectMake(center - (width / 2), x + height + spacing, width, width));
}

@end
