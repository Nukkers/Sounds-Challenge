//
//  BBCSMPTitleSubtitleController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTitleSubtitleScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UILabel;

@interface BBCSMPTitleSubtitleController : NSObject <BBCSMPTitleSubtitleScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithTitleLabel:(UILabel *)titleLabel
                     subtitleLabel:(UILabel *)subtitleLabel NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
