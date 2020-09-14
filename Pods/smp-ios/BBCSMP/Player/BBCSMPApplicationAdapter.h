//
//  BBCSMPApplicationAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/04/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPApplicationAdapter <NSObject>
@required

- (void)beginReceivingRemoteControlEvents;
- (void)endReceivingRemoteControlEvents;

@end
