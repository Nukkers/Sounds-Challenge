//
//  BBCSMPSubtitlesButtonController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSubtitlesButtonScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIButton;

@interface BBCSMPSubtitlesButtonController : NSObject <BBCSMPSubtitlesButtonScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEnableSubtitlesButton:(UIButton *)subtitlesButton
                       disableSubtitlesButton:(UIButton *)disableSubtitlesButton NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
