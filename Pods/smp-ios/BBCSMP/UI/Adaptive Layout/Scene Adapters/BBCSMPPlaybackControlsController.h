//
//  BBCSMPPlaybackControlsController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlaybackControlsScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIView;

@interface BBCSMPPlaybackControlsController : NSObject <BBCSMPPlaybackControlsScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlaybackControlsContainer:(UIView *)playbackControlsContainer NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
