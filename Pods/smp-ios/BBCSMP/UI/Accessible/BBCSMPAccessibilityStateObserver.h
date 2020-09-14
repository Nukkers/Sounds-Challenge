//
//  BBCSMPAccessibilityStateObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 06/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPAccessibilityStateObserver <NSObject>
@required

- (void)voiceoverDisabled;
- (void)voiceoverEnabled;
- (void)switchControlsEnabled;
- (void)switchControlsDisabled;

@end
