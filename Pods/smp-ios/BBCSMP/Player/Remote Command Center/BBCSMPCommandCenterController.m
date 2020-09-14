//
//  BBCSMPCommandCenterController.m
//  BBCSMP
//
//  Created by Richard Gilpin on 08/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPCommandCenterController.h"
#import "BBCSMPRemotePauseCommandController.h"
#import "BBCSMPRemotePlayCommandController.h"
#import "BBCSMPRemoteTogglePlayPauseCommandController.h"
#import "BBCSMPRemoteStopCommandRule.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPRemotePlayCommandRule.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPRemotePauseCommandRule.h"
#import "BBCSMPRulePlayerStateProvider.h"

@implementation BBCSMPCommandCenterController {
    __weak id<BBCSMP> _player;
    id<BBCSMPRemoteCommandCenter> _remoteCommandCenter;
    id<BBCSMPBackgroundStateProvider> _backgroundStateProviding;
    
    BBCSMPRemoteStopCommandRule *_stopRule;
    BBCSMPRemotePlayCommandRule *_playRule;
    BBCSMPRemotePauseCommandRule *_pauseRule;
    
    BBCSMPRemotePauseCommandController *_pauseCommandController;
    BBCSMPRemotePlayCommandController *_playCommandController;
    BBCSMPRemoteTogglePlayPauseCommandController *_togglePlayPauseCommandController;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
      backgroundStateProviding:(id<BBCSMPBackgroundStateProvider>)backgroundStateProviding
{
    self = [super init];
    if (self) {
        _player = player;
        _remoteCommandCenter = remoteCommandCenter;
        _backgroundStateProviding = backgroundStateProviding;
        
        [self makeRules];
        [self makeCommandControllers];
    }
    
    return self;
}

#pragma mark Public

- (void)unregisterFromRemoteCommandCenter
{
    [_pauseCommandController unregisterCommand];
    [_playCommandController unregisterCommand];
    [_togglePlayPauseCommandController unregisterCommand];
}

#pragma mark Private

- (void)makeRules
{
    BBCSMPRulePlayerStateProvider *ruleStateProvider = [[BBCSMPRulePlayerStateProvider alloc] initWithPlayer:_player
                                                                                    backgroundStateProviding:_backgroundStateProviding];
    _stopRule = [[BBCSMPRemoteStopCommandRule alloc] initWithRuleStateProvider:ruleStateProvider];
    _playRule = [[BBCSMPRemotePlayCommandRule alloc] initWithRuleStateProvider:ruleStateProvider];
    _pauseRule = [[BBCSMPRemotePauseCommandRule alloc] initWithRuleStateProvider:ruleStateProvider];
}

- (void)makeCommandControllers
{
    _pauseCommandController = [[BBCSMPRemotePauseCommandController alloc] initWithPlayer:_player
                                                                     remoteCommandCenter:_remoteCommandCenter
                                                                                stopRule:_stopRule
                                                                               pauseRule:_pauseRule];
    
    _playCommandController = [[BBCSMPRemotePlayCommandController alloc] initWithPlayer:_player
                                                                   remoteCommandCenter:_remoteCommandCenter
                                                                              playRule:_playRule];
    
    _togglePlayPauseCommandController = [[BBCSMPRemoteTogglePlayPauseCommandController alloc] initWithPlayer:_player
                                                                                         remoteCommandCenter:_remoteCommandCenter
                                                                                                    stopRule:_stopRule
                                                                                                    playRule:_playRule
                                                                                                   pauseRule:_pauseRule];
}

@end
