//
//  BBCSMPSliderDrawingUtils.h
//  BBCSMP
//
//  Created by Michael Emmens on 10/11/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const float BBCSMPVolumeSliderMaxVolume;
extern const CGFloat BBCSMPVolumeSliderStepWidth;

FOUNDATION_EXTERN UIImage * BBCSMPVolumeSliderThumbImage(void);

@interface BBCSMPVolumeDrawingUtils : NSObject

+ (void)drawSliderThumbInRect:(CGRect)rect;
+ (void)drawSliderTrackInRect:(CGRect)rect usingColor:(UIColor*)fillColor;

+ (void)drawSpeakerIcon:(UIColor*)color inFrame:(CGRect)iconFrame;
+ (void)drawMutedIcon:(UIColor*)color inFrame:(CGRect)iconFrame;
+ (void)drawSmallWaveIcon:(UIColor*)color inFrame:(CGRect)iconFrame;
+ (void)drawBigWaveIcon:(UIColor*)color inFrame:(CGRect)iconFrame;

@end
