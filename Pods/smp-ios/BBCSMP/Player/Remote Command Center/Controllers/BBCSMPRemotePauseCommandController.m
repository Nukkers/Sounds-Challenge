//
//  BBCSMPRemotePauseCommandController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemotePauseCommandController.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemoteCommandCenter.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPRemoteStopCommandRule.h"
#import "BBCSMPRemotePauseCommandRule.h"
#import "BBCSMPPauseCommandHandler.h"
#import "BBCSMPStopCommandHandler.h"

@implementation BBCSMPRemotePauseCommandController {
    __weak id<BBCSMP> _player;
    id<BBCSMPRemoteCommandCenter> _remoteCommandCenter;
    BBCSMPPauseCommandHandler* _pauseHandler;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
                      stopRule:(BBCSMPRemoteStopCommandRule*)stopRule
                     pauseRule:(BBCSMPRemotePauseCommandRule*)pauseRule
{
    self = [super init];
    if(self) {
        _player = player;
        _remoteCommandCenter = remoteCommandCenter;
        
        BBCSMPStopCommandHandler* stopHandler = [[BBCSMPStopCommandHandler alloc] initWithPlayer:_player stopRule:stopRule nextHandler:nil];
        _pauseHandler = [[BBCSMPPauseCommandHandler alloc] initWithPlayer:_player pauseRule:pauseRule nextHandler:stopHandler];
        
        [remoteCommandCenter addPauseTarget:_pauseHandler action:@selector(handle)];
    }
    
    return self;
}

#pragma mark Public

- (void)unregisterCommand
{
    [_remoteCommandCenter removePauseTarget:_pauseHandler];
}

@end
