//
//  BBCSMPRemoteStopCommandRule.m
//  BBCSMP
//
//  Created by Jenna Brown on 16/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemoteStopCommandRule.h"
#import "BBCSMPRulePlayerStateProvider.h"

@implementation BBCSMPRemoteStopCommandRule {
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

- (BOOL)shouldStop
{
    return _ruleStateProvider.isPlayingSimulcast &&
           !_ruleStateProvider.isLiveRewindable &&
           _ruleStateProvider.isPlayerPlaying;
}

@end
