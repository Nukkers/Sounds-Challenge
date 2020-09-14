//
//  BBCSMPInteractivityController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPActivityScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIButton;

@interface BBCSMPInteractivityController : NSObject <BBCSMPActivityScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithInteractivityButton:(UIButton *)interactivityButton NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
