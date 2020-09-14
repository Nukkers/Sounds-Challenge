//
//  BBCSMPAVPlayerPictureInPictureAdapterFactory-iOS.m
//  BBCSMP
//
//  Created by Timothy James Condon on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVPictureInPictureAdapterFactory.h"
#import "BBCSMPAVPictureInPictureAdapter.h"

@implementation BBCSMPAVPictureInPictureAdapterFactory

+ (id<BBCSMPPictureInPictureAdapter>)createPictureInPictureAdapterWithPlayerLayer:(AVPlayerLayer*)playerLayer
{
    return [[BBCSMPAVPictureInPictureAdapter alloc] initWithPlayerLayer:playerLayer];
}

@end
