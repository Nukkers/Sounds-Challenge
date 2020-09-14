//
//  BBCSMPAccessibilityChromeSuppression.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString* const kBBCSMPVoiceoverActiveReason;
FOUNDATION_EXTERN NSString* const kBBCSMPSwitchControlsActiveReason;

@protocol BBCSMPChromeSupression;
@protocol BBCSMPPlayerScenes;
@protocol BBCSMPAccessibilityStateProviding;

@interface BBCSMPAccessibilityChromeSuppression : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                                   scenes:(id<BBCSMPPlayerScenes>)scenes
              accessibilityStateProviding:(id<BBCSMPAccessibilityStateProviding>)accessibilityStateProviding NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
