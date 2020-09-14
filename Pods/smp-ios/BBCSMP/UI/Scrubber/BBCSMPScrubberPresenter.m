//
//  BBCSMPScrubberPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPScrubberPresenter.h"
#import "BBCSMPScrubberScene.h"
#import "BBCSMPUserInteractionObserver.h"
#import "BBCSMPScrubberController.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPState.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPItem.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPTime.h"
#import "BBCSMPTimeFormatter.h"
#import "BBCSMPBrand.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPTimeIntervalFormatter.h"

@interface BBCSMPScrubberPresenter () <BBCSMPItemObserver,
                                       BBCSMPScrubberInteractionObserver,
                                       BBCSMPStateObserver,
                                       BBCSMPTimeObserver>
@end

#pragma mark -

@implementation BBCSMPScrubberPresenter {
    __weak id<BBCSMPScrubberScene> _scrubberScene;
    __weak id<BBCSMP> _player;
    BBCSMPUserInteractionsTracer *_userInteractionsTracer;
    BBCSMPStateEnumeration _state;
    BBCSMPTimeRange *_seekableRange;
    BOOL _isLive;
    id<BBCSMPUIConfiguration> _configuration;
    BBCSMPTime *_time;
    id<BBCSMPTimeFormatterProtocol> _timeFormatter;
    BBCSMPDuration *_duration;
    BBCSMPAccessibilityIndex *_accessibilityIndex;
    id<BBCSMPTimeIntervalFormatter> _scrubberPositionFormatter;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _scrubberScene = context.view.scenes.scrubberScene;
        _player = context.player;
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        _configuration = context.configuration;
        _timeFormatter = context.timeFormatter;
        _scrubberPositionFormatter = context.scrubberPositionFormatter;
        _accessibilityIndex = context.brand.accessibilityIndex;
        
        [_scrubberScene hideScrubber];
        [context.presentationControllers.scrubberController addObserver:self];
        [context.player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _isLive = playerItem.metadata.streamType == BBCSMPStreamTypeSimulcast;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _state = state.state;
    [self updateScrubberVisibility];
}

#pragma mark BBCSMPScrubberInteractionObserver

- (void)scrubberDidBeginScrubbing {}

- (void)scrubberDidFinishScrubbing {}

- (void)scrubberDidScrubToPosition:(NSNumber *)position
{
    [self performScrubToTime:position.doubleValue];
}

- (void)scrubberDidReceiveAccessibilityIncrement
{
    [self performScrubToTime:_time.seconds + [_configuration accessibilityScrubAdjustmentValue]];
}

- (void)scrubberDidReceiveAccessibilityDecrement
{
    [self performScrubToTime:_time.seconds - [_configuration accessibilityScrubAdjustmentValue]];
}

#pragma mark BBCSMPTimeObserver

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    _seekableRange = range;
    [self updateScrubberVisibility];
}

- (void)timeChanged:(BBCSMPTime*)time
{
    _time = time;
    [self updateScrubberAccessibilityValue];
}

- (void)durationChanged:(BBCSMPDuration*)duration
{
    _duration = duration;
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime {}
- (void)playerRateChanged:(float)newPlayerRate {}

#pragma mark Private

- (void)updateScrubberVisibility
{
    switch (_state) {
        case BBCSMPStatePlaying:
        case BBCSMPStatePaused:
        case BBCSMPStateBuffering:
            if([self canShowScrubberForVOD] || [self canShowScrubberForSimulcast]) {
                [_scrubberScene showScrubber];
            }
            else {
                [_scrubberScene hideScrubber];
            }
            break;
            
        case BBCSMPStateIdle:
        case BBCSMPStateLoadingItem:
        case BBCSMPStateItemLoaded:
        case BBCSMPStatePreparingToPlay:
        case BBCSMPStatePlayerReady:
        case BBCSMPStateEnded:
        case BBCSMPStateError:
        case BBCSMPStateStopping:
            break;
    }
}

- (BOOL)canShowScrubberForVOD
{
    return !_isLive && _seekableRange;
}

- (BOOL)canShowScrubberForSimulcast
{
    return _isLive && _seekableRange.durationMeetsMinimumLiveRewindRequirement;
}

- (void)performScrubToTime:(NSTimeInterval)targetTime
{
    NSTimeInterval seekPosition = MAX(targetTime, _seekableRange.start);
    
    [_player scrubToPosition:seekPosition];
    [_userInteractionsTracer notifyObserversUsingBlock:^(id<BBCSMPUserInteractionObserver> observer) {
        [observer scrubbedToPosition:@(seekPosition)];
    }];
}

- (void)updateScrubberAccessibilityValue
{
    NSString *label = [_accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementScrubberSeekPosition];
    [_scrubberScene setScrubberAccessibilityLabel:label];
    
    NSString *value = [self makeAccessibilityValue];
    [_scrubberScene setScrubberAccessibilityValue:value];
}

- (NSString *)makeAccessibilityValue
{
    if (_time.secondsAsDate) {
        return [_scrubberPositionFormatter stringFromDate:_time.secondsAsDate];
    }
    else {
        return [_scrubberPositionFormatter stringFromSeconds:_time.seconds];
    }
}

@end
