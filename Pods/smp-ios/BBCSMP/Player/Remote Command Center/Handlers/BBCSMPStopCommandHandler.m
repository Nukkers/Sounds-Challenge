//
//  BBCSMPStopCommandHandler.m
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPStopCommandHandler.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemoteStopCommandRule.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation BBCSMPStopCommandHandler {
    __weak id<BBCSMP> _player;
    BBCSMPRemoteStopCommandRule* _stopRule;
    id<BBCSMPCommandCenterControlHandler> _nextHandler;
}

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                      stopRule:(BBCSMPRemoteStopCommandRule *)stopRule
                   nextHandler:(id<BBCSMPCommandCenterControlHandler>)commandCenterControlHandler
{
    self = [super init];
    if (self) {
        _player = player;
        _stopRule = stopRule;
        _nextHandler = commandCenterControlHandler;
    }
    
    return self;
}

#pragma mark BBCSMPCommandCenterControlHandler

- (MPRemoteCommandHandlerStatus)handle
{
    if (_stopRule.shouldStop) {
        [_player stop];
    }
    else {
        [_nextHandler handle];
    }
    
    return MPRemoteCommandHandlerStatusSuccess;
}

@end
