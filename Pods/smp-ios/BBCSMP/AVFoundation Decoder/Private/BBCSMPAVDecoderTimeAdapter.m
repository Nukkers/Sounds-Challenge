//
//  BBCSMPAVDecoderTimeAdapter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVDecoderTimeAdapter.h"
#import "BBCSMPAVSeekController.h"
#import "BBCSMPDuration.h"
#import "BBCSMPEventBus.h"
#import <AVFoundation/AVPlayerItem.h>
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVDecoderTimeAdapter {
    __weak AVPlayerItem * _Nullable _playerItem;
    BBCSMPAVSeekController* _seekController;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                  seekController:(BBCSMPAVSeekController*)seekController
{
    self = [super init];
    if (self) {
        _seekController = seekController;
        [eventBus addTarget:self selector:@selector(playerItemDidChange:) forEventType:[BBCSMPAVPlayerItemChangedEvent class]];
    }

    return self;
}

#pragma mark Public

- (BBCSMPDuration*)duration
{
    CMTime cmDuration = _playerItem.duration;
    NSTimeInterval durationValue = (cmDuration.value == 0.0f) ? 0.0f : CMTimeGetSeconds(cmDuration);
    return [BBCSMPDuration duration:durationValue];
}

#pragma mark Target Action

- (void)playerItemDidChange:(BBCSMPAVPlayerItemChangedEvent *)event
{
    _playerItem = event.playerItem;
}

@end
