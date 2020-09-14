//
//  BBCSMPTelemetryManager.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTelemetryManager.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPCommonAVReporting.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPIntentToPlayManager.h"
#import "BBCSMPHeartbeatManager.h"
#import "BBCSMPTelemetryErrorManager.h"
#import "BBCSMPTelemetryLastRequestedItemTracker.h"
#import "BBCSMPState.h"
#import "BBCSMPSessionIdentifierProvider.h"
#import "BBCSMPPlaySuccessManager.h"
#import "BBCSMPAirplayObserver.h"

@interface BBCSMPTelemetryManager () <BBCSMPStateObserver, BBCSMPTimeObserver, BBCSMPPlayerBitrateObserver, BBCSMPAirplayObserver>
@end

#pragma mark -

@implementation BBCSMPTelemetryManager {
    BBCSMPIntentToPlayManager *_intentToPlayManager;
    BBCSMPHeartbeatManager *_heartbeatManager;
    BBCSMPTelemetryErrorManager *_errorManager;
    BBCSMPPlaySuccessManager *_playSuccessManager;
    id<BBCSMPSessionIdentifierProvider> _sessionIdentifierProvider;
    BBCSMPTelemetryLastRequestedItemTracker *_lastRequestedItemTracker;

}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
            AVMonitoringClient:(id<BBCSMPCommonAVReporting>)AVMonitoringClient
                      eventBus:(BBCSMPEventBus *)eventBus
     sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider
{
    self = [super init];
    
    if(self) {
        _sessionIdentifierProvider = sessionIdentifierProvider;
        
        _lastRequestedItemTracker = [[BBCSMPTelemetryLastRequestedItemTracker alloc] initWithEventBus:eventBus];

        _intentToPlayManager = [[BBCSMPIntentToPlayManager alloc] initWithAVMonitoringClient: AVMonitoringClient eventBus:eventBus sessionIdentifierProvider:sessionIdentifierProvider lastRequestedItemTracker:_lastRequestedItemTracker];
        _playSuccessManager = [[BBCSMPPlaySuccessManager alloc] initWithAVMonitoringClient:AVMonitoringClient sessionIdentifierProvider:sessionIdentifierProvider lastRequestedItemTracker:_lastRequestedItemTracker];
        _heartbeatManager = [[BBCSMPHeartbeatManager alloc] initWithAVMonitoringClient:AVMonitoringClient eventBus:eventBus sessionIdentifierProvider:sessionIdentifierProvider lastRequestedItemTracker:_lastRequestedItemTracker];
        _errorManager = [[BBCSMPTelemetryErrorManager alloc] initWithAVMonitoringClient:AVMonitoringClient eventBus:eventBus sessionIdentifierProvider:sessionIdentifierProvider lastRequestedItemTracker:_lastRequestedItemTracker];
        
        
        [player addObserver:self];
    }
    
    return self;
}

#pragma mark Public

- (void)clockDidTickToTime:(BBCSMPClockTime *)clockTime {
    
    [_heartbeatManager clockDidTickToTime:clockTime];
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    [self startNewTelemetrySessionWhenStateEnds:state];
    [_intentToPlayManager stateChanged:state];
    [_heartbeatManager stateChanged:state];
    [_playSuccessManager stateChanged:state];
}

- (void)startNewTelemetrySessionWhenStateEnds:(BBCSMPState*)state
{
    BBCSMPStateEnumeration newState = state.state;

    if (newState == BBCSMPStateEnded || newState == BBCSMPStateError || newState == BBCSMPStateStopping) {
        [_sessionIdentifierProvider newSessionStarted];
    }
}

#pragma mark BBCSMPTimeObserver

- (void)durationChanged:(BBCSMPDuration*)duration
{
    [_heartbeatManager durationChanged:duration];
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    [_heartbeatManager seekableRangeChanged:range];
}

- (void)timeChanged:(BBCSMPTime*)time
{
    [_heartbeatManager timeChanged:time];
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime
{
    [_heartbeatManager scrubbedFromTime:fromTime toTime:toTime];
}

- (void)playerRateChanged:(float)newPlayerRate
{
    [_heartbeatManager playerRateChanged:newPlayerRate];
}

- (void)playerBitrateChanged:(double)bitrate
{
    [_heartbeatManager playerBitrateChanged:bitrate];
    [_errorManager playerBitrateChanged:bitrate];
}

#pragma mark BBCSMPAirplayObserver


- (void)airplayActivationChanged:(nonnull NSNumber *)active {
    [_heartbeatManager airplayActivationChanged: active];
}

- (void)airplayAvailabilityChanged:(nonnull NSNumber *)available {
    
}

@end
