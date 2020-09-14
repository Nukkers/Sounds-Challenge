//
//  BBCSMPPlaybackPausedStateAction.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityStateAction.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPAccessibilityIndex;
@protocol BBCSMPAccessibilityAnnouncer;

@interface BBCSMPPlaybackPausedStateAction : NSObject <BBCSMPAccessibilityStateAction>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithAnnouncer:(id<BBCSMPAccessibilityAnnouncer>)announcer
               accessibilityIndex:(BBCSMPAccessibilityIndex *)index NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
