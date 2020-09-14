//
//  BBCSMPTitleBarController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTitleBarScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIView;

@interface BBCSMPTitleBarController : NSObject <BBCSMPTitleBarScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithTitleBarContainer:(UIView *)titleBarContainer NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
