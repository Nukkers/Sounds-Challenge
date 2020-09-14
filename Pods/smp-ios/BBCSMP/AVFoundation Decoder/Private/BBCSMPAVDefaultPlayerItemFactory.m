//
//  BBCSMPDefaultAVPlayerItemFactory.m
//  SMP
//
//  Created by Richard Gilpin on 23/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVDefaultPlayerItemFactory.h"
#import <AVFoundation/AVPlayerItem.h>

@implementation BBCSMPAVDefaultPlayerItemFactory

- (AVPlayerItem *)createPlayerItemWithURL:(NSURL *)url
{
    return [AVPlayerItem playerItemWithURL:url];
}

@end
