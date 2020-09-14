//
//  BBCSMPSuppressChromeWhenEnded.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromeSupression.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPSuppressChromeWhenEnded.h"
#import <SMP/SMP-Swift.h>

static NSString* const kBBCSMPEndedStateSuppressionReason = @"Playback Ended";

@interface BBCSMPSuppressChromeWhenEnded () <BBCSMPPlaybackStateObserver>
@end

#pragma mark -

@implementation BBCSMPSuppressChromeWhenEnded {
    __weak id<BBCSMPChromeSupression> _chromeSuppression;
    __weak id<BBCSMP> _player;
}

#pragma mark Initialization

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                                   player:(id<BBCSMP>)player
{
    self = [super init];
    if (self) {
        _chromeSuppression = chromeSuppression;
        _player = player;

        [player addStateObserver:self];
    }

    return self;
}

#pragma mark BBCSMPPlaybackStateObserver

- (void)state:(id<SMPPlaybackState> _Nonnull)state {
    if ([(id)state isKindOfClass:[SMPPlaybackStateEnded class]]) {
        [_chromeSuppression suppressControlAutohideForReason:kBBCSMPEndedStateSuppressionReason];
    }
    else {
        [_chromeSuppression stopSuppressingControlAutohideForReason:kBBCSMPEndedStateSuppressionReason];
    }
}

@end
