//
//  BBCSMPIconFactory.m
//  BBCSMP
//
//  Created by Michael Emmens on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPIconFactory.h"
#import "BBCSMPBlockBasedIcon.h"
#import "BBCSMPVolumeDrawingUtils.h"

@implementation BBCSMPIconFactory

+ (id<BBCSMPIcon>)playIcon
{
    return [BBCSMPBlockBasedIcon iconWithBlock:^(UIColor* colour, CGRect iconFrame) {
        // Set-up bezier path for a triangle
        UIBezierPath* trianglePath = [UIBezierPath bezierPath];
        [trianglePath moveToPoint:CGPointMake(CGRectGetMinX(iconFrame) + CGRectGetWidth(iconFrame) * 2.0f / 28.0f, CGRectGetMinY(iconFrame))];
        [trianglePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + CGRectGetWidth(iconFrame) * 2.0f / 28.0f, CGRectGetMaxY(iconFrame))];
        [trianglePath addLineToPoint:CGPointMake(CGRectGetMinX(iconFrame) + CGRectGetWidth(iconFrame) * 24.0f / 28.0f, CGRectGetMinY(iconFrame) + iconFrame.size.height * 0.5)];
        [trianglePath closePath];

        // Fill it!
        [colour setFill];
        [trianglePath fill];
    }];
}

+ (id<BBCSMPIcon>)pauseIcon
{
    return [BBCSMPBlockBasedIcon iconWithBlock:^(UIColor* colour, CGRect iconFrame) {
        // Set-up bezier paths for two rectangles
        CGFloat offset = (iconFrame.size.width * 6.0f) / 16.0f;
        UIBezierPath* rectangle1Path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame), offset, CGRectGetHeight(iconFrame))];
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMaxX(iconFrame) - offset, CGRectGetMinY(iconFrame), offset, CGRectGetHeight(iconFrame))];

        // Fill them!
        [colour setFill];
        [rectangle1Path fill];
        [rectangle2Path fill];
    }];
}

+ (id<BBCSMPIcon>)stopIcon
{
    return [BBCSMPBlockBasedIcon iconWithBlock:^(UIColor* colour, CGRect iconFrame) {
        // Set-up bezier path for a square
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:iconFrame];

        // Fill it!
        [colour setFill];
        [rectanglePath fill];
    }];
}

+ (id<BBCSMPIcon>)audioPlayIcon
{
    return [BBCSMPBlockBasedIcon iconWithBlock:^(UIColor* colour, CGRect iconFrame) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);

        CGContextTranslateCTM(context, iconFrame.origin.x, iconFrame.origin.y);
        CGFloat scaleFactor = MIN(iconFrame.size.width, iconFrame.size.height) / 22.0f;
        CGContextScaleCTM(context, scaleFactor, scaleFactor); // BBCSMPVolumeDrawingUtils assumes we draw icon at 22x22

        CGRect drawingFrame = CGRectMake(0, 0, iconFrame.size.width, iconFrame.size.height);
        [BBCSMPVolumeDrawingUtils drawSpeakerIcon:colour inFrame:drawingFrame];
        [BBCSMPVolumeDrawingUtils drawSmallWaveIcon:colour inFrame:drawingFrame];
        [BBCSMPVolumeDrawingUtils drawBigWaveIcon:colour inFrame:drawingFrame];

        CGContextRestoreGState(context);
    }];
}

@end
