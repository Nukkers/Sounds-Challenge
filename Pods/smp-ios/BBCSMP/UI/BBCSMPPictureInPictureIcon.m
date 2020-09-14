//
//  BBCSMPPictureInPictureIcon.m
//  BBCSMP
//
//  Created by Al Priest on 01/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPictureInPictureIcon.h"
#import <AVKit/AVKit.h>

@implementation BBCSMPPictureInPictureIcon

- (void)drawInFrame:(CGRect)frame
{
    UIImage* icon = self.image;
    [self.colour set];
    CGFloat width = 22.0;
    CGFloat height = width / (icon.size.width / icon.size.height);
    CGFloat top = (CGRectGetHeight(frame) - height) / 2.0;
    CGRect iconFrame = CGRectMake(11, top, width, height);
    [icon drawInRect:iconFrame];
}

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"

@implementation BBCSMPEnablePictureInPictureIcon

- (UIImage*)image
{
    return [[AVPictureInPictureController pictureInPictureButtonStartImageCompatibleWithTraitCollection:self.traitCollection] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end

@implementation BBCSMPDisablePictureInPictureIcon

- (UIImage*)image
{
    return [[AVPictureInPictureController pictureInPictureButtonStopImageCompatibleWithTraitCollection:self.traitCollection] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end

#pragma clang diagnostic pop
