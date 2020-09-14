//
//  BBCSMPPlayerBitrateObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 16/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@protocol BBCSMPPlayerBitrateObserver <BBCSMPObserver>

- (void)playerBitrateChanged:(double)bitrate;

@end
