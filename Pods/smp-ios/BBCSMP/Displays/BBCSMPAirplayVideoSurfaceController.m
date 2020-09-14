//
//  BBCSMPAirplayVideoSurfaceController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAirplayVideoSurface.h"
#import "BBCSMPAirplayVideoSurfaceController.h"
#import "BBCSMPDisplayCoordinatorProtocol.h"

@interface BBCSMPAirplayVideoSurfaceController ()

@property (nonatomic, weak) id<BBCSMPDisplayCoordinatorProtocol> displayCoordinator;
@property (nonatomic, strong) BBCSMPAirplayVideoSurface* airplayVideoSurface;

@end

@implementation BBCSMPAirplayVideoSurfaceController

- (instancetype)initWithDisplayCoordinator:(id<BBCSMPDisplayCoordinatorProtocol>)displayCoordinator
{
    self = [super init];

    if (self) {
        _displayCoordinator = displayCoordinator;
        _airplayVideoSurface = [BBCSMPAirplayVideoSurface new];
    }

    return self;
}

#pragma mark - BBCSMPAirplayObserver

- (void)airplayActivationChanged:(NSNumber*)active
{
    if (active.boolValue) {
        [_displayCoordinator attachVideoSurface:_airplayVideoSurface];
    }
    else {
        [_displayCoordinator detachVideoSurface:_airplayVideoSurface];
    }
}

- (void)airplayAvailabilityChanged:(NSNumber*)available
{
}

@end
