//
//  BBCSMPTimeLabelPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 26/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPItem.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPTimeFormatterProtocol.h"
#import "BBCSMPTimeLabelPresenter.h"
#import "BBCSMPTimeLabelScene.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPState.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPTime.h"
#import "UIColor+SMPPalette.h"

@interface BBCSMPTimeLabelPresenter () <BBCSMPItemObserver, BBCSMPStateObserver, BBCSMPTimeObserver>
@end

#pragma mark -

@implementation BBCSMPTimeLabelPresenter {
    __weak id<BBCSMPTimeLabelScene> _scene;
    id<BBCSMPTimeFormatterProtocol> _timeFormatter;
    BBCSMPDuration* _duration;
    BBCSMPTime* _time;
    BOOL _live;
    BOOL _liveRewindableRange;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _scene = context.view.scenes.timeLabelScene;
        _timeFormatter = context.timeFormatter;
        _live = NO;
        _liveRewindableRange = NO;
        
        [context.player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _live = playerItem.metadata.streamType == BBCSMPStreamTypeSimulcast;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    switch (state.state) {
    case BBCSMPStatePlaying:
    case BBCSMPStatePaused:
    case BBCSMPStateBuffering:
        [_scene showTime];
        break;

    case BBCSMPStateIdle:
    case BBCSMPStateStopping:
    case BBCSMPStateItemLoaded:
    case BBCSMPStateLoadingItem:
    case BBCSMPStatePreparingToPlay:
        [_scene hideTime];
        break;
            
    case BBCSMPStatePlayerReady:
        if(!_live) {
            [_scene showTime];
        }
        
        break;

    case BBCSMPStateEnded:
    case BBCSMPStateError:
        [_scene hideTime];
        break;
    }
}

#pragma mark BBCSMPTimeObserver

- (void)durationChanged:(BBCSMPDuration*)duration
{
    _duration = duration;
    [self updateScene];
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    _liveRewindableRange = range.durationMeetsMinimumLiveRewindRequirement;
    [self updateScene];
}

- (void)timeChanged:(BBCSMPTime*)time
{
    if (![_time isEqual:time]) {
        _time = time;
        [self updateScene];
    }
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime
{
}

- (void)playerRateChanged:(float)playerRate
{
}

#pragma mark Private

- (void)updateScene
{
    NSString *playheadPositionString = [_timeFormatter stringFromTime:_time];
    if (_time.type == BBCSMPTimeRelative) {
        NSString *durationString = [_timeFormatter stringFromDuration:_duration];
        [_scene setRelativeTimeStringWithPlayheadPosition:playheadPositionString
                                                 duration:durationString];
    }
    else {
        [_scene setAbsoluteTimeString:playheadPositionString];
    }
    
}

@end
