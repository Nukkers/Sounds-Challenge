//
//  BBCSMPPictureInPictureAvailabilityObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPPictureInPictureAvailabilityObserver <BBCSMPObserver>

- (void)pictureInPictureAvailabilityDidChange:(BOOL)pictureInPictureAvailable NS_SWIFT_NAME(pictureInPictureAvailabilityChanged(_:));

@end
