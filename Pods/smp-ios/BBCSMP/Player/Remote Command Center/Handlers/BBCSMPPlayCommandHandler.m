//
//  BBCSMPPlayCommandHandler.m
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlayCommandHandler.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemotePlayCommandRule.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation BBCSMPPlayCommandHandler {
    __weak id<BBCSMP> _player;
    BBCSMPRemotePlayCommandRule* _playRule;
    id<BBCSMPCommandCenterControlHandler> _nextHandler;
}

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                      playRule:(BBCSMPRemotePlayCommandRule *)playRule
                   nextHandler:(id<BBCSMPCommandCenterControlHandler>)commandCenterControlHandler
{
    self = [super init];
    if (self) {
        _player = player;
        _playRule = playRule;
        _nextHandler = commandCenterControlHandler;
    }
    
    return self;
}

#pragma mark BBCSMPCommandCenterControlHandler

- (MPRemoteCommandHandlerStatus)handle
{
    if (_playRule.shouldPlay) {
       [_player play];
    }
    else {
        [_nextHandler handle];
    }
    
    return MPRemoteCommandHandlerStatusSuccess;
}

@end
