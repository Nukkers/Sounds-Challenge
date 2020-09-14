//
//  BBCSMPBackgroundObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/03/2016.
//  Copyright (c) 2016 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPBackgroundObserver <BBCSMPObserver>

- (void)playerEnteredBackgroundState;
- (void)playerWillResignActive;
- (void)playerEnteredForegroundState;

@end