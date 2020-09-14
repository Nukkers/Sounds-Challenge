//
//  BBCSMPRemotePlayCommandRule.m
//  BBCSMP
//
//  Created by Ryan Johnstone on 11/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRemotePlayCommandRule.h"
#import "BBCSMPRulePlayerStateProvider.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPItem.h"

@implementation BBCSMPRemotePlayCommandRule {
    BBCSMPRulePlayerStateProvider *_ruleStateProvider;
}

#pragma mark Initialization

- (instancetype)initWithRuleStateProvider:(BBCSMPRulePlayerStateProvider *)ruleStateProvider
{
    self = [super init];
    if(self) {
        _ruleStateProvider = ruleStateProvider;
    }
    
    return self;
}

#pragma mark Public

- (BOOL)shouldPlay
{
    return (_ruleStateProvider.playerItem.metadata.avType == BBCSMPAVTypeAudio ||
            !_ruleStateProvider.isInBackground ||
            _ruleStateProvider.airplayActive ||
            _ruleStateProvider.isInPictureInPicture) &&
            !_ruleStateProvider.isPlayerPlaying;
}

@end
