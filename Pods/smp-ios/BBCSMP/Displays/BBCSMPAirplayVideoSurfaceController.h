//
//  BBCSMPAirplayVideoSurfaceController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPAirplayObserver.h"

@protocol BBCSMPDisplayCoordinatorProtocol;

@interface BBCSMPAirplayVideoSurfaceController : NSObject <BBCSMPAirplayObserver>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithDisplayCoordinator:(id<BBCSMPDisplayCoordinatorProtocol>)displayCoordinator;

@end
