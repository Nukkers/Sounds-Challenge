//
//  BBCSMPArrowIcon.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 23/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPArrowIcon.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPArrowIcon

#pragma mark Convienince Factory Methods

+ (instancetype)arrowWithDirection:(BBCSMPArrowDirection)direction
{
    BBCSMPArrowIcon* arrow = [self new];
    arrow.direction = direction;
    return arrow;
}

+ (instancetype)northEastArrow
{
    return [self arrowWithDirection:BBCSMPArrowDirectionNorthEast];
}

+ (instancetype)northWestArrow
{
    return [self arrowWithDirection:BBCSMPArrowDirectionNorthWest];
}

+ (instancetype)sorthEastArrow
{
    return [self arrowWithDirection:BBCSMPArrowDirectionSouthEast];
}

+ (instancetype)southWestArrow
{
    return [self arrowWithDirection:BBCSMPArrowDirectionSouthWest];
}

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colour = [UIColor whiteColor];
        _headHeightSizeProportion = 0.5;
        _stemWidthSizeProportion = 0.33;
        _direction = BBCSMPArrowDirectionNorth;
    }

    return self;
}

#pragma mark Icon Drawing

- (void)drawInFrame:(CGRect)frame
{
    CGFloat height = CGRectGetHeight(frame), width = CGRectGetWidth(frame);
    CGFloat headHeight = height * _headHeightSizeProportion;
    CGFloat stemWidth = width * _stemWidthSizeProportion;
    CGFloat stemRight = (width + stemWidth) / 2.0, stemLeft = stemRight - stemWidth;

    // We'll draw the basic shape of the arrow first, then orientate the path
    // in the desired direction and fill.
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width / 2.0, 0.0)];
    [path addLineToPoint:CGPointMake(width, headHeight)];
    [path addLineToPoint:CGPointMake(stemRight, headHeight)];
    [path addLineToPoint:CGPointMake(stemRight, height)];
    [path addLineToPoint:CGPointMake(stemLeft, height)];
    [path addLineToPoint:CGPointMake(stemLeft, headHeight)];
    [path addLineToPoint:CGPointMake(0.0, headHeight)];
    [path closePath];

    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, CGRectGetMinX(frame), CGRectGetMinY(frame));

    CGRect bounds = path.bounds;
    CGFloat midX = CGRectGetMidX(bounds), midY = CGRectGetMidY(bounds);

    transform = CGAffineTransformTranslate(transform, midX, midY);
    transform = CGAffineTransformRotate(transform, [self rotationAngleForDirection]);
    transform = CGAffineTransformTranslate(transform, -midX, -midY);
    [path applyTransform:transform];

    [self.colour setFill];
    [path fill];
}

- (CGFloat)rotationAngleForDirection
{
    switch (_direction) {
    case BBCSMPArrowDirectionNorthEast:
        return 3.0 * M_PI_4;

    case BBCSMPArrowDirectionSouthEast:
        return M_PI_4;

    case BBCSMPArrowDirectionSouthWest:
        return -M_PI_4;

    case BBCSMPArrowDirectionNorthWest:
        return -(3.0 * M_PI_4);

    case BBCSMPArrowDirectionNorth:
    default:
        return -M_PI;
    }
}

@end
