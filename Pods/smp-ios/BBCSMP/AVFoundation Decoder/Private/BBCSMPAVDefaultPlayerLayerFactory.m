//
//  BBCSMPDefaultAVPlayerLayerFactory.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVDefaultPlayerLayerFactory.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVDefaultPlayerLayerFactory

- (AVPlayerLayer*)playerLayerWithPlayer:(id<AVPlayerProtocol>)player
{
    return [AVPlayerLayer playerLayerWithPlayer:player];
}

@end
