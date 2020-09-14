//
//  BBCSMPAirplayVideoSurface.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAirplayVideoSurface.h"

@implementation BBCSMPAirplayVideoSurface

- (BBCSMPVideoSurfacePriority)priority
{
    return 100;
}

- (BOOL)shouldPlayInBackground
{
    return YES;
}

- (BOOL)shouldPauseWhenDetached
{
    return YES;
}

- (void)attachWithContext:(BBCSMPVideoSurfaceContext*)context
{
}

- (void)detach
{
}

@end
