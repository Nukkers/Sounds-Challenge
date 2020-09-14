//
//  BBCSMPLiveIndicatorPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPLiveIndicatorPresenter.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPLiveIndicatorScene.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPItem.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPState.h"
#import "BBCSMPTime.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPBrand.h"
#import "BBCSMPAccessibilityIndex.h"

@interface BBCSMPLiveIndicatorPresenter () <BBCSMPItemObserver, BBCSMPStateObserver, BBCSMPTimeObserver>
@end

#pragma mark -

@implementation BBCSMPLiveIndicatorPresenter {
    __weak id<BBCSMPLiveIndicatorScene> _scene;
    id<BBCSMPItem> _currentItem;
    id<BBCSMPUIConfiguration> _configuration;
    BBCSMPState* _currentState;
    BBCSMPTime* _currentTime;
    BBCSMPTimeRange* _seekableRanges;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _scene = context.view.scenes.liveIndicatorScene;
        _configuration = context.configuration;
        [context.player addObserver:self];
        [_scene setLiveIndicatorAccessibilityLabel:[context.brand.accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementLiveIndicator]];
    }
    
    return self;
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _currentItem = playerItem;
    [self updateLabelPresentation];
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _currentState = state;
    [self updateLabelPresentation];
}

#pragma mark BBCSMPTimeObserver

- (void)durationChanged:(BBCSMPDuration*)duration
{
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    _seekableRanges = range;
    [self updateLabelPresentation];
}

- (void)timeChanged:(BBCSMPTime*)time
{
    _currentTime = time;
    [self updateLabelPresentation];
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime;
{
}

- (void)playerRateChanged:(float)newPlayerRate
{
}

#pragma mark Private

- (void)updateLabelPresentation
{
    if ([self shouldPresentLiveLabel]) {
        [_scene showLiveLabel];
    }
    else {
        [_scene hideLiveLabel];
    }
}

- (BOOL)shouldPresentLiveLabel
{
    return _currentItem.metadata.streamType == BBCSMPStreamTypeSimulcast &&
        [self canShowLabelForCurrentState] &&
        [self isContentFlushWithLiveEdgeWithinTolerance];
}

- (BOOL)canShowLabelForCurrentState
{
    return _currentState.state == BBCSMPStatePlaying || _currentState.state == BBCSMPStatePaused || _currentState.state == BBCSMPStateBuffering;
}

- (BOOL)isContentFlushWithLiveEdgeWithinTolerance
{
    return _currentTime.seconds >= (_seekableRanges.end - [_configuration liveIndicatorEdgeTolerance]);
}

@end
