//
//  BBCSMPSliderDrawingUtils.m
//  BBCSMP
//
//  Created by Michael Emmens on 10/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPVolumeDrawingUtils.h"
#import "UIColor+SMPPalette.h"

const float BBCSMPVolumeSliderMaxVolume = 11.0f;
const CGFloat BBCSMPVolumeSliderStepWidth = 11.0f;

UIImage * BBCSMPVolumeSliderThumbImage()
{
    static UIImage *thumbImage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(20.0, 20.0), NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        CGContextFillEllipseInRect(context, CGRectMake(0, 0, 20.0, 20.0));
        
        thumbImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    
    return thumbImage;
}

@implementation BBCSMPVolumeDrawingUtils

const CGFloat BBCSMPSliderDrawingUtilsStepHorizontalInset = 4.0f;
const CGFloat BBCSMPSliderDrawingUtilsStepVerticalInset = 8.0f;

+ (void)drawSliderThumbInRect:(CGRect)rect
{
    [self drawBarInRect:rect usingFillColor:[UIColor SMPWhiteColor] withHeightAdjustment:4.0f];
}

+ (void)drawSliderTrackInRect:(CGRect)rect usingColor:(UIColor*)fillColor
{
    [self drawBarInRect:rect usingFillColor:fillColor withHeightAdjustment:0];
}

+ (void)drawBarInRect:(CGRect)rect usingFillColor:(UIColor*)fillColor withHeightAdjustment:(CGFloat)heightAdjustment
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect stepRect = CGRectInset(rect, BBCSMPSliderDrawingUtilsStepHorizontalInset, BBCSMPSliderDrawingUtilsStepVerticalInset);
    stepRect.origin.y -= heightAdjustment;
    stepRect.size.height += heightAdjustment;
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    CGContextFillRect(context, stepRect);
}

+ (void)drawSpeakerIcon:(UIColor*)color inFrame:(CGRect)iconFrame
{
    UIBezierPath* speakerIconPath = [UIBezierPath bezierPath];
    [speakerIconPath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 15)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 6, CGRectGetMinY(iconFrame) + 15)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 21)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 15)];
    [speakerIconPath closePath];
    [speakerIconPath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 7)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 6, CGRectGetMinY(iconFrame) + 7)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 1)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 7)];
    [speakerIconPath closePath];
    [speakerIconPath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 1, CGRectGetMinY(iconFrame) + 15)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 15)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 12, CGRectGetMinY(iconFrame) + 7)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 1, CGRectGetMinY(iconFrame) + 7)];
    [speakerIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 1, CGRectGetMinY(iconFrame) + 15)];
    [speakerIconPath closePath];
    [color setFill];
    [speakerIconPath fill];
}

+ (void)drawMutedIcon:(UIColor*)color inFrame:(CGRect)iconFrame
{
    UIBezierPath* mutedIconPath = [UIBezierPath bezierPath];
    [mutedIconPath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13, CGRectGetMinY(iconFrame) + 7)];
    [mutedIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 20.9, CGRectGetMinY(iconFrame) + 14.96)];
    [mutedIconPath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 20.93, CGRectGetMinY(iconFrame) + 14.99) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 20.93, CGRectGetMinY(iconFrame) + 14.99) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 20.93, CGRectGetMinY(iconFrame) + 14.99)];
    [mutedIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13, CGRectGetMinY(iconFrame) + 7)];
    [mutedIconPath closePath];
    [mutedIconPath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 21.22, CGRectGetMinY(iconFrame) + 7)];
    [mutedIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.33, CGRectGetMinY(iconFrame) + 14.96)];
    [mutedIconPath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.25, CGRectGetMinY(iconFrame) + 15.03) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 13.26, CGRectGetMinY(iconFrame) + 15.02) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 13.25, CGRectGetMinY(iconFrame) + 15.03)];
    [mutedIconPath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 21.22, CGRectGetMinY(iconFrame) + 7)];
    [mutedIconPath closePath];
    [color setStroke];
    mutedIconPath.lineWidth = 1.5;
    [mutedIconPath stroke];
}

+ (void)drawSmallWaveIcon:(UIColor*)color inFrame:(CGRect)iconFrame
{
    UIBezierPath* smallwavePath = [UIBezierPath bezierPath];
    [smallwavePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.73, CGRectGetMinY(iconFrame) + 3.77)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.41, CGRectGetMinY(iconFrame) + 3.77)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.41, CGRectGetMinY(iconFrame) + 4.13)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.41, CGRectGetMinY(iconFrame) + 3.72)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.73, CGRectGetMinY(iconFrame) + 3.77)];
    [smallwavePath closePath];
    [smallwavePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.54, CGRectGetMinY(iconFrame) + 4.34)];
    [smallwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15.27, CGRectGetMinY(iconFrame) + 5.99) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 14.19, CGRectGetMinY(iconFrame) + 4.71) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 14.78, CGRectGetMinY(iconFrame) + 5.28)];
    [smallwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15.27, CGRectGetMinY(iconFrame) + 16.01) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 17.18, CGRectGetMinY(iconFrame) + 8.77) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 17.18, CGRectGetMinY(iconFrame) + 13.23)];
    [smallwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.53, CGRectGetMinY(iconFrame) + 17.66) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 14.78, CGRectGetMinY(iconFrame) + 16.72) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 14.19, CGRectGetMinY(iconFrame) + 17.28)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.53, CGRectGetMinY(iconFrame) + 16.66)];
    [smallwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.29, CGRectGetMinY(iconFrame) + 15.77) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 13.8, CGRectGetMinY(iconFrame) + 16.41) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 14.05, CGRectGetMinY(iconFrame) + 16.11)];
    [smallwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.29, CGRectGetMinY(iconFrame) + 6.23) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 16.1, CGRectGetMinY(iconFrame) + 13.15) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 16.1, CGRectGetMinY(iconFrame) + 8.85)];
    [smallwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.53, CGRectGetMinY(iconFrame) + 5.34) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 14.05, CGRectGetMinY(iconFrame) + 5.89) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 13.8, CGRectGetMinY(iconFrame) + 5.59)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.53, CGRectGetMinY(iconFrame) + 4.34)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 13.54, CGRectGetMinY(iconFrame) + 4.34)];
    [smallwavePath closePath];
    [smallwavePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.41, CGRectGetMinY(iconFrame) + 18.28)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.41, CGRectGetMinY(iconFrame) + 18.23)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.75, CGRectGetMinY(iconFrame) + 18.23)];
    [smallwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 11.41, CGRectGetMinY(iconFrame) + 18.28)];
    [smallwavePath closePath];
    smallwavePath.lineWidth = 1.5;
    [color setFill];
    [smallwavePath fill];
}

+ (void)drawBigWaveIcon:(UIColor*)color inFrame:(CGRect)iconFrame
{
    UIBezierPath* bigwavePath = [UIBezierPath bezierPath];
    [bigwavePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15.04, CGRectGetMinY(iconFrame) + 0.65)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.59, CGRectGetMinY(iconFrame) + 0.65)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.59, CGRectGetMinY(iconFrame) + 1.16)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.59, CGRectGetMinY(iconFrame) + 0.58)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15.04, CGRectGetMinY(iconFrame) + 0.65)];
    [bigwavePath closePath];
    [bigwavePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 17.57, CGRectGetMinY(iconFrame) + 1.47)];
    [bigwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 19.99, CGRectGetMinY(iconFrame) + 3.83) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 18.47, CGRectGetMinY(iconFrame) + 2) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 19.3, CGRectGetMinY(iconFrame) + 2.8)];
    [bigwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 19.99, CGRectGetMinY(iconFrame) + 18.17) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 22.67, CGRectGetMinY(iconFrame) + 7.8) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 22.67, CGRectGetMinY(iconFrame) + 14.19)];
    [bigwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 17.55, CGRectGetMinY(iconFrame) + 20.53) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 19.3, CGRectGetMinY(iconFrame) + 19.19) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 18.48, CGRectGetMinY(iconFrame) + 19.99)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 17.55, CGRectGetMinY(iconFrame) + 19.1)];
    [bigwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 18.62, CGRectGetMinY(iconFrame) + 17.83) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 17.93, CGRectGetMinY(iconFrame) + 18.75) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 18.29, CGRectGetMinY(iconFrame) + 18.32)];
    [bigwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 18.62, CGRectGetMinY(iconFrame) + 4.17) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 21.15, CGRectGetMinY(iconFrame) + 14.07) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 21.15, CGRectGetMinY(iconFrame) + 7.93)];
    [bigwavePath addCurveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 17.55, CGRectGetMinY(iconFrame) + 2.89) controlPoint1:CGPointMake(CGRectGetMinX(iconFrame) + 18.29, CGRectGetMinY(iconFrame) + 3.68) controlPoint2:CGPointMake(CGRectGetMinX(iconFrame) + 17.93, CGRectGetMinY(iconFrame) + 3.25)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 17.55, CGRectGetMinY(iconFrame) + 1.46)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 17.57, CGRectGetMinY(iconFrame) + 1.47)];
    [bigwavePath closePath];
    [bigwavePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.59, CGRectGetMinY(iconFrame) + 21.43)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.59, CGRectGetMinY(iconFrame) + 21.35)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 15.06, CGRectGetMinY(iconFrame) + 21.35)];
    [bigwavePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + 14.59, CGRectGetMinY(iconFrame) + 21.43)];
    [bigwavePath closePath];
    bigwavePath.lineWidth = 1.5;
    [color setFill];
    [bigwavePath fill];
}

@end
