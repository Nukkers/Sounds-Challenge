//
//  BBCSMPDefaultAVComponentFactory.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 14/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVAudioSessionProtocol.h"
#import "AVPlayerProtocol.h"
#import "BBCSMPAVDefaultComponentFactory.h"
#import <AVFoundation/AVFoundation.h>
#import <SMP/SMP-Swift.h>

@interface AVPlayer (SMPCompatibility) <AVPlayerProtocol>
@end

@implementation AVPlayer (SMPCompatibility)
@end

@interface AVAudioSession (SMPCompatibility) <AVAudioSessionProtocol>
@end

@implementation AVAudioSession (SMPCompatibility)
@end

#pragma mark -

@implementation BBCSMPAVDefaultComponentFactory

- (id<AVAudioSessionProtocol>)audioSession
{
    return [AVAudioSession sharedInstance];
}

- (id<AVPlayerProtocol>)createPlayer
{
    return [[AVPlayer alloc] init];
}

@end
