//
//  BBCSMPSwitchControlsStateProviding.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/07/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPSwitchControlsStateProviding <NSObject>
@required

@property (nonatomic, assign, readonly, getter=isSwitchControlsRunning) BOOL switchControlsRunning;

@end
