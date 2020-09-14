//
//  BBCSMPTransportControlsSpaceRestrictedObserver.h
//  BBCSMP
//
//  Created by Ryan Johnstone on 19/12/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

@protocol BBCSMPTransportControlsSpaceObserver <NSObject>

- (void)spaceRestricted;
- (void)spaceAvailable;

@end
