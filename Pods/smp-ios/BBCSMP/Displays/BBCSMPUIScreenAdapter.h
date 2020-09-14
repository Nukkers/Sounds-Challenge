//
//  BBCSMPUIScreenAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPVideoSurface.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIScreen;
@class UIWindow;

@interface BBCSMPUIScreenAdapter : NSObject <BBCSMPVideoSurface>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) UIWindow* window;

- (instancetype)initWithScreen:(UIScreen*)screen NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
