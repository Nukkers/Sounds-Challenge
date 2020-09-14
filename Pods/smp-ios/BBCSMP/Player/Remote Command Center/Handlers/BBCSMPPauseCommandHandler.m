//
//  BBCSMPPauseCommandHandler.m
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPauseCommandHandler.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemotePauseCommandRule.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation BBCSMPPauseCommandHandler {
    __weak id<BBCSMP> _player;
    BBCSMPRemotePauseCommandRule* _pauseRule;
    id<BBCSMPCommandCenterControlHandler> _nextHandler;
}

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                     pauseRule:(BBCSMPRemotePauseCommandRule*)pauseRule
                   nextHandler:(id<BBCSMPCommandCenterControlHandler>)commandCenterControlHandler
{
    self = [super init];
    if (self) {
        _player = player;
        _pauseRule = pauseRule;
        _nextHandler = commandCenterControlHandler;
    }
    
    return self;
}

#pragma mark BBCSMPCommandCenterControlHandler

- (MPRemoteCommandHandlerStatus)handle
{
    if (_pauseRule.shouldPause) {
        [_player pause];
    }
    else {
        [_nextHandler handle];
    }
    
    return MPRemoteCommandHandlerStatusSuccess;
}

@end
