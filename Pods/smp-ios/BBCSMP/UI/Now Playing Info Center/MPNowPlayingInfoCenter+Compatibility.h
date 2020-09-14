//
//  MPNowPlayingInfoCenter+MPNowPlayingInfoCenter_Compatibility.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "MPNowPlayingInfoCenterProtocol.h"

@interface MPNowPlayingInfoCenter (Compatibility) <MPNowPlayingInfoCenterProtocol>
@end
