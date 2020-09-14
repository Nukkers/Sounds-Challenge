//
//  BBCSMPSubtitlesController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSubtitleScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPSubtitleView;

@interface BBCSMPSubtitlesController : NSObject <BBCSMPSubtitleScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithSubtitlesView:(BBCSMPSubtitleView *)subtitlesView NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
