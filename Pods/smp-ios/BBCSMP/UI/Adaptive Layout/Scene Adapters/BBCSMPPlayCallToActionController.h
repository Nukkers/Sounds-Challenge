//
//  BBCSMPPlayCallToActionController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlayCTAButtonScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIButton;
@class UILabel;

@interface BBCSMPPlayCallToActionController : NSObject <BBCSMPPlayCTAButtonScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithCallToActionButton:(UIButton *)callToActionButton
                             durationLabel:(UILabel *)durationLabel NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
