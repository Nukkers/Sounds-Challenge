//
//  BBCSMPCloseButtonController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPCloseButtonScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPIconButton;
@protocol BBCSMPMeasurementPolicy;

@interface BBCSMPCloseButtonController : NSObject <BBCSMPCloseButtonScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithCloseButton:(BBCSMPIconButton *)closeButton
              iconMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)iconMeasurementPolicy NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
