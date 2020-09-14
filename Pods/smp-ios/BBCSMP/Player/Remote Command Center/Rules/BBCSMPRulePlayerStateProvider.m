//
//  BBCSMPRulePlayerStateProvider.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPRulePlayerStateProvider.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPBackgroundObserver.h"
#import "BBCSMPBackgroundStateProvider.h"
#import "BBCSMPAirplayObserver.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPPictureInPictureControllerObserver.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPItem.h"
#import "BBCSMPState.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPTimeRange.h"

@interface BBCSMPRulePlayerStateProvider () <BBCSMPAirplayObserver,
                                             BBCSMPBackgroundObserver,
                                             BBCSMPItemObserver,
                                             BBCSMPPictureInPictureControllerObserver,
                                             BBCSMPStateObserver, BBCSMPTimeObserver>
@end

#pragma mark -

@implementation BBCSMPRulePlayerStateProvider

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
      backgroundStateProviding:(id<BBCSMPBackgroundStateProvider>)backgroundStateProviding
{
    self = [super init];
    if(self) {
        [player addObserver:self];
        [backgroundStateProviding addObserver:self];
    }
    
    return self;
}

#pragma mark Public

- (BOOL)isPlayingSimulcast
{
    return _playerItem.metadata.streamType == BBCSMPStreamTypeSimulcast;
}

- (BOOL)isPlayerPlaying
{
    return _state == BBCSMPStatePlaying;
}

#pragma mark BBCSMPAirplayObserver

- (void)airplayActivationChanged:(NSNumber *)active
{
    _airplayActive = active.boolValue;
}

- (void)airplayAvailabilityChanged:(NSNumber *)available {}

#pragma mark BBCSMPBackgroundObserver

- (void)playerEnteredBackgroundState
{
    _isInBackground = YES;
}

- (void)playerWillResignActive {}

- (void)playerEnteredForegroundState
{
    _isInBackground = NO;
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _playerItem = playerItem;
}

#pragma mark BBCSMPPictureInPictureControllerObserver

- (void)didStartPictureInPicture
{
    _isInPictureInPicture = YES;
}

- (void)didStopPictureInPicture
{
    _isInPictureInPicture = NO;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _state = state.state;
}

#pragma mark BBCSMPTimeObserver

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    _isLiveRewindable = range.durationMeetsMinimumLiveRewindRequirement;
}

- (void)durationChanged:(BBCSMPDuration*)duration {}
- (void)timeChanged:(BBCSMPTime*)time { }
- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime {}
- (void)playerRateChanged:(float)newPlayerRate {}

@end
