//
//  BBCSMPRemotePauseCommandRule.m
//  BBCSMP
//
//  Created by Richard Gilpin on 17/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemotePauseCommandRule.h"
#import "BBCSMPRulePlayerStateProvider.h"
#import "BBCSMPState.h"

@implementation BBCSMPRemotePauseCommandRule {
    BBCSMPRulePlayerStateProvider* _ruleStateProvider;
}

#pragma mark Initialization

- (instancetype)initWithRuleStateProvider:(BBCSMPRulePlayerStateProvider *)ruleStateProvider
{
    self = [super init];
    if (self) {
        _ruleStateProvider = ruleStateProvider;
    }
    
    return self;
}

#pragma mark Public

- (BOOL)shouldPause
{
    return _ruleStateProvider.state != BBCSMPStateIdle &&
           _ruleStateProvider.state != BBCSMPStatePaused &&
           _ruleStateProvider.state != BBCSMPStateBuffering &&
           (!_ruleStateProvider.isPlayingSimulcast || _ruleStateProvider.isLiveRewindable);
}

@end
