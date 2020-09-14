//
//  BBCSMPUIAccessibilityStateProviding.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityStateProviding.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPVoiceoverStateProviding;
@protocol BBCSMPSwitchControlsStateProviding;

@interface BBCSMPUIAccessibilityStateProviding : NSObject <BBCSMPAccessibilityStateProviding>

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
                   voiceoverStateProviding:(id<BBCSMPVoiceoverStateProviding>)voiceoverStateProviding
              switchControlsStateProviding:(id<BBCSMPSwitchControlsStateProviding>)switchControlsStateProviding NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
