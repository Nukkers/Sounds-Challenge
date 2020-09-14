//
//  BBCSMPRelativeScaleMeasurementPolicy.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRelativeScaleMeasurementPolicy.h"

@implementation BBCSMPRelativeScaleMeasurementPolicy {
    double _scaleFactor;
    CGAffineTransform _scaleTransform;
}

#pragma mark Initialization

+ (instancetype)policyWithScaleFactor:(double)scaleFactor
{
    return [[self alloc] initWithScaleFactor:scaleFactor];
}

- (instancetype)initWithScaleFactor:(double)scaleFactor
{
    self = [super init];
    if(self) {
        _scaleFactor = scaleFactor;
        _scaleTransform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    }
    
    return self;
}

#pragma mark Overrides

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"%@ - %f", [super debugDescription], _scaleFactor];
}

#pragma mark BBCSMPMeasurementPolicy

- (CGRect)preferredBoundsForDrawingInRect:(CGRect)rect
{
    CGRect scaledRect = CGRectApplyAffineTransform(rect, _scaleTransform);

    CGFloat positionX = CGRectGetMidX(rect) - CGRectGetMidX(scaledRect);
    CGFloat positionY = CGRectGetMidY(rect) - CGRectGetMidY(scaledRect);
    CGAffineTransform scaleTranslate = CGAffineTransformMakeTranslation(positionX, positionY);
    
    return CGRectApplyAffineTransform(scaledRect, scaleTranslate);
}

@end
