//
//  BBCSMPPictureInPictureControllerObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPPictureInPictureControllerObserver <BBCSMPObserver>

- (void)didStartPictureInPicture;
- (void)didStopPictureInPicture;

@end
