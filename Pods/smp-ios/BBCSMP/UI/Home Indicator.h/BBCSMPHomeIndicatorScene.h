//
//  BBCSMPHomeIndicatorScene.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPHomeIndicatorScene <NSObject>
@required

- (void)disableHomeIndicatorAutohiding;
- (void)enableHomeIndicatorAutohiding;
- (void)updateHomeIndicatorAutoHiddenState;

@end
