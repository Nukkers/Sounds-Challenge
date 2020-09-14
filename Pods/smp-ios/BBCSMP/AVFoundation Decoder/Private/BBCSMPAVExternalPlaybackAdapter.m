//
//  BBCSMPAVPlayerExternalPlaybackAdapter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVExternalPlaybackAdapter.h"
#import "BBCSMPEventBus.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVExternalPlaybackAdapter {
    id<AVPlayerProtocol> _player;
    BOOL _externalPlaybackActive;
}

@synthesize delegate;

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus player:(id<AVPlayerProtocol>)player
{
    self = [super init];
    if (self) {
        _player = player;
        [eventBus addTarget:self selector:@selector(playheadDidMove:) forEventType:[BBCSMPAVPlayheadMovedEvent class]];
        [self updateAirplayState];
    }

    return self;
}

- (void)playheadDidMove:(__unused BBCSMPAVPlayheadMovedEvent *)event
{
    [self updateAirplayState];
}

- (BOOL)isExternalPlaybackActive
{
    return _externalPlaybackActive;
}

- (void)updateAirplayState
{
    BOOL airplayActive = _player.isExternalPlaybackActive;

    if (_externalPlaybackActive != airplayActive) {
        _externalPlaybackActive = airplayActive;

        if (airplayActive) {
            [self.delegate externalPlaybackAdapterDidBeginAirplayPlayback:self];
        }
        else {
            [self.delegate externalPlaybackAdapterDidEndAirplayPlayback:self];
        }
    }
}

@end
