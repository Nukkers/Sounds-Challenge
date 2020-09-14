//
//  BBCSMPExpandVideoIcon.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 23/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPExpandVideoIcon.h"
#import "BBCSMPArrowIcon.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPExpandVideoIcon

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colour = [UIColor whiteColor];
    }

    return self;
}

#pragma mark Icon Drawing

- (void)drawInFrame:(CGRect)frame
{
    CGFloat width = CGRectGetWidth(frame), height = CGRectGetHeight(frame);
    CGFloat arrowScaleFactor = 0.42;
    CGSize arrowSize = CGSizeMake(width * arrowScaleFactor, height * arrowScaleFactor);
    CGFloat left = CGRectGetMinX(frame), right = left + (width - arrowSize.width);
    CGFloat top = CGRectGetMinY(frame), bottom = CGRectGetMinY(frame) + (height - arrowSize.height);

    BBCSMPArrowIcon* northEastArrow = [BBCSMPArrowIcon northEastArrow];
    CGPoint northEastOrigin = CGPointMake(right, bottom);
    [self drawArrowIcon:northEastArrow origin:northEastOrigin size:arrowSize];

    BBCSMPArrowIcon* southEastArrow = [BBCSMPArrowIcon sorthEastArrow];
    CGPoint southEastOrigin = CGPointMake(right, top);
    [self drawArrowIcon:southEastArrow origin:southEastOrigin size:arrowSize];

    BBCSMPArrowIcon* southWestArrow = [BBCSMPArrowIcon southWestArrow];
    CGPoint southWestOrigin = CGPointMake(left, top);
    [self drawArrowIcon:southWestArrow origin:southWestOrigin size:arrowSize];

    BBCSMPArrowIcon* northWestArrow = [BBCSMPArrowIcon northWestArrow];
    CGPoint northWestOrigin = CGPointMake(left, bottom);
    [self drawArrowIcon:northWestArrow origin:northWestOrigin size:arrowSize];
}

- (void)drawArrowIcon:(id<BBCSMPIcon>)arrowIcon origin:(CGPoint)origin size:(CGSize)size
{
    CGRect frame = {.origin = origin, .size = size };
    [arrowIcon setColour:self.colour];
    [arrowIcon drawInFrame:frame];
}

@end
