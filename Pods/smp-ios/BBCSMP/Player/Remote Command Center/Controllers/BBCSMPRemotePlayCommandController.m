//
//  BBCSMPRemotePlayCommandController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemotePlayCommandController.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemoteCommandCenter.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPRemotePlayCommandRule.h"
#import "BBCSMPPlayCommandHandler.h"

@implementation BBCSMPRemotePlayCommandController {
    __weak id<BBCSMP> _player;
    id<BBCSMPRemoteCommandCenter> _remoteCommandCenter;
    BBCSMPPlayCommandHandler* _playHandler;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
                      playRule:(BBCSMPRemotePlayCommandRule *)playRule
{
    self = [super init];
    if(self) {
        _player = player;
        _remoteCommandCenter = remoteCommandCenter;

        _playHandler = [[BBCSMPPlayCommandHandler alloc] initWithPlayer:_player playRule:playRule nextHandler:nil];
        
        [remoteCommandCenter addPlayTarget:_playHandler action:@selector(handle)];
    }
    
    return self;
}

#pragma mark Public

- (void)unregisterCommand
{
    [_remoteCommandCenter removePlayTarget:_playHandler];
}

@end
