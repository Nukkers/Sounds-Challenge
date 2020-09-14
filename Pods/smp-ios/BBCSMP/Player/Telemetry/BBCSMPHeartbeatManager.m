//
//  BBCSMPHeartbeatManager.m
//  BBCSMP
//
//  Created by Tim Condon on 16/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPHeartbeatManager.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"
#import "BBCSMPItemLoadedEvent.h"
#import "BBCSMPItemProviderUpdatedEvent.h"
#import "BBCSMPState.h"
#import "BBCSMPClockTime.h"
#import "BBCSMPTelemetryLastRequestedItemTracker.h"
#import "BBCSMPCommonAVReporting.h"
#import "BBCSMPMediaBitrate.h"
#import "BBCSMPVideoSurfaceAttachmentEvent.h"
#import "BBCSMPEventBus.h"
#import <math.h>

#pragma mark Properties

static const NSTimeInterval BBCSMPInitialHeartbeatTimeInterval = 10.0;
static const NSTimeInterval BBCSMPHeartbeatInterval = 60.0;

@implementation BBCSMPHeartbeatManager {
    id<BBCSMPCommonAVReporting> _AVMonitoringClient;
    BBCSMPStateEnumeration _state;
    BBCSMPDuration *_duration;
    BBCSMPClockTime *_clockTime;
    BBCSMPClockTime *_playbackStartTime;
    BBCSMPTime *_currentTime;
    BBCSMPTimeRange *_seekableRange;
    id<BBCSMPSessionIdentifierProvider> _sessionIdentifierProvider;
    BBCSMPTelemetryLastRequestedItemTracker *_lastRequestedItemTracker;
    BBCSMPMediaBitrate* _mediaBitrate;
    NSString* _airplayStatus;
    NSNumber* _numberOfScreens;
}

#pragma mark Initialisation

-(instancetype)initWithAVMonitoringClient:(id)AVMonitoringClient eventBus:(BBCSMPEventBus *)eventBus sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider lastRequestedItemTracker:(nonnull BBCSMPTelemetryLastRequestedItemTracker *)lastRequestedItemTracker{
    self = [super init];
    
    if (self) {
        _AVMonitoringClient = AVMonitoringClient;
        
        _lastRequestedItemTracker = lastRequestedItemTracker;
        
        _sessionIdentifierProvider = sessionIdentifierProvider;
        
        [eventBus addTarget:self
                   selector:@selector(handleVideoSurfaceAttachedEvent:)
                      forEventType:[BBCSMPVideoSurfaceAttachmentEvent class]];

    }
    
    
    return self;
}

#pragma mark Public

- (void)clockDidTickToTime:(BBCSMPClockTime *)clockTime {
    
    if (![clockTime isEqual:_clockTime]) {
        _clockTime = clockTime;
        long timeElapsed = [clockTime secondsSinceTime:_playbackStartTime];
        
        if (timeElapsed == BBCSMPInitialHeartbeatTimeInterval || (timeElapsed != 0.0 && fmod(timeElapsed, BBCSMPHeartbeatInterval) == 0.0)) {
            if(_state == BBCSMPStatePlaying) {
                [self sendHeartbeatWithTime:_currentTime];
            }
        }
    }
}

#pragma mark Private

- (void)sendHeartbeatWithTime:(BBCSMPTime*)currentTime
{
    [_AVMonitoringClient trackHeartbeatWithVPID:_lastRequestedItemTracker.vpidForCurrentItem
                                         AVType:_lastRequestedItemTracker.avType
                                     streamType:_lastRequestedItemTracker.streamType
                                    currentTime:currentTime
                                       duration:_duration
                                  seekableRange:_seekableRange
                                       supplier:_lastRequestedItemTracker.supplier
                                 transferFormat:_lastRequestedItemTracker.transferFormat
                                   mediaBitrate:_mediaBitrate
                                libraryMetadata:[[BBCSMPCommonAVReportingLibraryMetadata alloc] initWithLibraryName:_lastRequestedItemTracker.libraryName andVersion:_lastRequestedItemTracker.libraryVersion]
                                  airplayStatus:_airplayStatus
                                numberOfScreens:_numberOfScreens];
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _state = state.state;
    
    if(_state == BBCSMPStatePlaying && _playbackStartTime == nil) {
        _playbackStartTime = _clockTime;
    }
    
    if(_state == BBCSMPStateEnded || _state == BBCSMPStateStopping) {
        if (_playbackStartTime != nil) {
            [self sendHeartbeatWithTime:_currentTime];
        }
    }
    
    if(_state == BBCSMPStateEnded || _state == BBCSMPStateError || _state == BBCSMPStateLoadingItem) {
        _playbackStartTime = nil;
    }
}

#pragma mark BBCSMPTimeObserver

- (void)durationChanged:(BBCSMPDuration*)duration
{
    _duration = duration;
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    _seekableRange = range;
}

- (void)timeChanged:(BBCSMPTime*)time
{
    _currentTime = time;
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime {}
- (void)playerRateChanged:(float)newPlayerRate {}

#pragma mark BBCSMPPlayerBitrateObserver

- (void)playerBitrateChanged:(double)bitrate
{
    _mediaBitrate = [[BBCSMPMediaBitrate alloc] initWithBitrate:bitrate];
}

- (void)airplayActivationChanged:(nonnull NSNumber *)active {
    BOOL airplayActive = active.boolValue;
    
    if (airplayActive) {
        _airplayStatus = @"active";
    } else {
        _airplayStatus = @"inactive";
    }
    
}

- (void)airplayAvailabilityChanged:(nonnull NSNumber *)available {}

- (void)handleVideoSurfaceAttachedEvent:(BBCSMPVideoSurfaceAttachmentEvent *)event {
    _numberOfScreens = event.videoSurfaces;
}

@end
