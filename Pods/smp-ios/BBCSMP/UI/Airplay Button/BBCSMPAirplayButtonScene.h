//
//  BBCSMPAirplayButtonScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPAirplayButtonScene <NSObject>
@required

- (void)showAirplayButton;
- (void)hideAirplayButton;

@end
