//
//  BBCSMPStopButtonController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPStopButtonScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPIconButton;
@protocol BBCSMPMeasurementPolicy;

@interface BBCSMPStopButtonController : NSObject <BBCSMPStopButtonScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithStopButton:(BBCSMPIconButton *)stopButton
             iconMeasurementPolicy:(id<BBCSMPMeasurementPolicy>)iconMeasurementPolicy NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
