//
//  BBCSMPAVPlayerPictureInPictureAdapter.h
//  BBCSMP
//
//  Created by Al Priest on 04/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPPictureInPictureAdapter.h"

@class AVPlayerLayer;

@interface BBCSMPAVPictureInPictureAdapter : NSObject <BBCSMPPictureInPictureAdapter>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayerLayer:(AVPlayerLayer*)playerLayer NS_DESIGNATED_INITIALIZER;

@end
