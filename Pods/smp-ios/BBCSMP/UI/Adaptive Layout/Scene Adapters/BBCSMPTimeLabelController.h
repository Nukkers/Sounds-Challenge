//
//  BBCSMPTimeLabelController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTimeLabelScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UILabel;

@interface BBCSMPTimeLabelController : NSObject <BBCSMPTimeLabelScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithRelativeTimeLabel:(UILabel *)timeLabel
                 relativeTimeDividerLabel:(UILabel *)relativeTimeDividerLabel
                relativeTimeDurationLabel:(UILabel *)relativeTimeDurationLabel
                        absoluteTimeLabel:(UILabel *)absoluteTimeLabel NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
