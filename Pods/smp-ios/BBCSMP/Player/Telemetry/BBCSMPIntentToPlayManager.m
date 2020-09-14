//
//  BBCSMPIntentToPlayManager.m
//  BBCSMP
//
//  Created by Tim Condon on 16/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPIntentToPlayManager.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPPlayRequestedEvent.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"
#import "BBCSMPItemLoadedEvent.h"
#import "BBCSMPItemProviderUpdatedEvent.h"
#import "BBCSMPInternalErrorEvent.h"
#import "BBCSMPSessionIdentifierProvider.h"
#import "BBCSMPState.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPTelemetryLastRequestedItemTracker.h"
#import "BBCSMPCommonAVReporting.h"

#pragma mark Properties

@implementation BBCSMPIntentToPlayManager {
    id<BBCSMPCommonAVReporting> _AVMonitoringClient;
    BBCSMPStateEnumeration _state;
    BOOL _intentToPlaySent;
    id<BBCSMPSessionIdentifierProvider> _sessionIdentifierProvider;
    BBCSMPTelemetryLastRequestedItemTracker *_lastRequestedItemTracker;
}

#pragma mark Initialisation

-(instancetype)initWithAVMonitoringClient:(id)AVMonitoringClient eventBus:(BBCSMPEventBus *)eventBus sessionIdentifierProvider:(id<BBCSMPSessionIdentifierProvider>)sessionIdentifierProvider lastRequestedItemTracker:(nonnull BBCSMPTelemetryLastRequestedItemTracker *)lastRequestedItemTracker {
    self = [super init];
    
    if (self) {
        _AVMonitoringClient = AVMonitoringClient;
        _sessionIdentifierProvider = sessionIdentifierProvider;
        
        [eventBus addTarget:self
                   selector:@selector(handlePlayEvent:)
               forEventType:[BBCSMPPlayRequestedEvent class]];
        
        [eventBus addTarget:self
                   selector:@selector(handleInternalErrorEvent)
               forEventType:[BBCSMPInternalErrorEvent class]];
        
        
        [eventBus addTarget:self
                   selector:@selector(handleItemProviderUpdatedEvent)
               forEventType:[BBCSMPItemProviderUpdatedEvent class]];
        
        _lastRequestedItemTracker = lastRequestedItemTracker;
    }
    
    return self;
}

#pragma mark Private

- (void)handlePlayEvent:(BBCSMPPlayRequestedEvent *)event
{
    if([self shouldSendIntentToPlay]) {
        [self sendIntentToPlay];
    }
}

- (void)handleInternalErrorEvent
{
    _intentToPlaySent = NO;
}

- (void)sendIntentToPlay
{
    [_AVMonitoringClient trackIntentToPlayWithVPID:_lastRequestedItemTracker.vpidForCurrentItem
                                            AVType:_lastRequestedItemTracker.avType
                                        streamType:_lastRequestedItemTracker.streamType
                                   libraryMetadata:[[BBCSMPCommonAVReportingLibraryMetadata alloc] initWithLibraryName:_lastRequestedItemTracker.libraryName andVersion:_lastRequestedItemTracker.libraryVersion]];
    _intentToPlaySent = YES;
}

- (BOOL)shouldSendIntentToPlay
{
    return !(_intentToPlaySent || _state == BBCSMPStateEnded);
}

- (void)handleItemProviderUpdatedEvent {
    _intentToPlaySent = NO;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _state = state.state;
    
    [self setIntentToPlayToNoWhenStateEnds:state];
    
    if(_state == BBCSMPStatePlaying && !_intentToPlaySent) {
        [self sendIntentToPlay];
    }
}

- (void)setIntentToPlayToNoWhenStateEnds:(BBCSMPState*)state
{
    _state = state.state;
    
    if (_state == BBCSMPStateEnded || _state == BBCSMPStateError || _state == BBCSMPStateStopping) {
        _intentToPlaySent = NO;
    }
}

@end
