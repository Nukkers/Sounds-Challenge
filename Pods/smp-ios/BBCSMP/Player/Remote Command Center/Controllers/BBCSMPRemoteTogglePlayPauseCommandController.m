//
//  BBCSMPRemoteTogglePlayPauseCommandController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemoteTogglePlayPauseCommandController.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemoteCommandCenter.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPRemotePauseCommandRule.h"
#import "BBCSMPRemotePlayCommandRule.h"
#import "BBCSMPRemoteStopCommandRule.h"
#import "BBCSMPPlayCommandHandler.h"
#import "BBCSMPPauseCommandHandler.h"
#import "BBCSMPStopCommandHandler.h"

@implementation BBCSMPRemoteTogglePlayPauseCommandController {
    __weak id<BBCSMP> _player;
    id<BBCSMPRemoteCommandCenter> _remoteCommandCenter;
    BBCSMPStopCommandHandler* _stopHandler;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
                      stopRule:(BBCSMPRemoteStopCommandRule *)stopRule
                      playRule:(BBCSMPRemotePlayCommandRule *)playRule
                     pauseRule:(BBCSMPRemotePauseCommandRule *)pauseRule
{
    self = [super init];
    if(self) {
        _player = player;
        _remoteCommandCenter = remoteCommandCenter;
        
        BBCSMPPauseCommandHandler* pauseHandler = [[BBCSMPPauseCommandHandler alloc] initWithPlayer: _player pauseRule: pauseRule nextHandler:nil];
        BBCSMPPlayCommandHandler* playHandler = [[BBCSMPPlayCommandHandler alloc] initWithPlayer:_player playRule:playRule nextHandler:pauseHandler];
        _stopHandler = [[BBCSMPStopCommandHandler alloc] initWithPlayer: _player stopRule: stopRule nextHandler:playHandler];
        
        [remoteCommandCenter addTogglePlayPauseTarget:_stopHandler action:@selector(handle)];
    }
    
    return self;
}

#pragma mark Public

- (void)unregisterCommand
{
    [_remoteCommandCenter removeTogglePlayPauseTarget:_stopHandler];
}

@end
