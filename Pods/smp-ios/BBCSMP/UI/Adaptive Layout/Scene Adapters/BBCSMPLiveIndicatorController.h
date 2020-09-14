//
//  BBCSMPLiveIndicatorController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPLiveIndicatorScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIView;

@interface BBCSMPLiveIndicatorController : NSObject <BBCSMPLiveIndicatorScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithLiveIndicator:(UIView *)liveIndicator NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
