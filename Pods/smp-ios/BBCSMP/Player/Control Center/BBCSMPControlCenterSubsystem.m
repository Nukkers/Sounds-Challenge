//
//  BBCSMPControlCenterSubsystem.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPControlCenterSubsystem.h"
#import "BBCSMPCommandCenterController.h"
#import "BBCSMPNowPlayingInfoManager.h"

@implementation BBCSMPControlCenterSubsystem {
    BBCSMPCommandCenterController *_commandCenterController;
    BBCSMPNowPlayingInfoManager *_nowPlayingInfoManager;
}

- (instancetype)initWithPlayer:(id<BBCSMP>)player
          nowPlayingInfoCenter:(id<MPNowPlayingInfoCenterProtocol>)nowPlayingInfoCenter
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
      backgroundStateProviding:(id<BBCSMPBackgroundStateProvider>)backgroundStateProviding
{
    self = [super init];
    if(self) {
        _commandCenterController = [[BBCSMPCommandCenterController alloc] initWithPlayer:player
                                                                     remoteCommandCenter:remoteCommandCenter
                                                                backgroundStateProviding:backgroundStateProviding];
        _nowPlayingInfoManager = [[BBCSMPNowPlayingInfoManager alloc] initWithPlayer:player
                                                                nowPlayingInfoCenter:nowPlayingInfoCenter];
    }
    
    return self;
}

- (void)teardown
{
    [_commandCenterController unregisterFromRemoteCommandCenter];
}

@end
