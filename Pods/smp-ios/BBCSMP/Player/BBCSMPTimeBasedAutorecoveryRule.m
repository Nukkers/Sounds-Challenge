//
//  BBCSMPTimeBasedAutorecoveryRule.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 03/11/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTimeBasedAutorecoveryRule.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPTimerProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPState.h"
#import "BBCSMPPlayerObservable.h"
#import "BBCSMPTimerFactory.h"

@interface BBCSMPTimeBasedAutorecoveryRule () <BBCSMPStateObserver>
@end

#pragma mark -

@implementation BBCSMPTimeBasedAutorecoveryRule {
    id<BBCSMPTimerFactoryProtocol> _timerFactory;
    NSTimeInterval _autorecoveryInterval;
    id<BBCSMPTimerProtocol> _timer;
    BOOL _timerElapsed;
}

#pragma mark Initialization

- (instancetype)initWithPermittedAutorecoveryInterval:(NSTimeInterval)autorecoveryInterval
{
    return self = [self initWithTimerFactory:[[BBCSMPTimerFactory alloc] init] permittedAutorecoveryInterval:autorecoveryInterval];
}

- (instancetype)initWithTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
       permittedAutorecoveryInterval:(NSTimeInterval)autorecoveryInterval
{
    self = [super init];
    if (self) {
        _timerFactory = timerFactory;
        _autorecoveryInterval = autorecoveryInterval;
    }
    
    return self;
}

#pragma mark Target Action

- (void)timerElapsed
{
    _timerElapsed = YES;
    [_delegate autorecoveryShouldAbandonPlayback];
}

#pragma mark BBCSMPAutorecoveryRule

@synthesize delegate = _delegate;

- (void)attachToPlayerObservable:(id<BBCSMPPlayerObservable>)playerObservable
{
    [playerObservable addObserver:self];
}

- (void)evaluate
{
    if (_timerElapsed) {
        [_delegate autorecoveryShouldAbandonPlayback];
    }
    else {
        [_delegate autorecoveryShouldBePerformed];
    }
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _timerElapsed = NO;
    if ([self shouldStopTimerForState:state]) {
        [_timer stop];
        _timer = nil;
    }
    
    if (!_timer && [self shouldBeginTimerForState:state]) {
        _timer = [_timerFactory timerWithInterval:_autorecoveryInterval
                                           target:self
                                         selector:@selector(timerElapsed)];
    }
}

#pragma mark Private

- (BOOL)shouldBeginTimerForState:(BBCSMPState *)state
{
    switch (state.state) {
        case BBCSMPStateIdle:
        case BBCSMPStatePlaying:
        case BBCSMPStatePlayerReady:
        case BBCSMPStateBuffering:
        case BBCSMPStatePaused:
        case BBCSMPStateEnded:
        case BBCSMPStateError:
        case BBCSMPStateStopping:
            return NO;
            
        default:
            return YES;
    }
}

- (BOOL)shouldStopTimerForState:(BBCSMPState *)state
{
    switch (state.state) {
        case BBCSMPStateItemLoaded:
        case BBCSMPStatePreparingToPlay:
        case BBCSMPStateLoadingItem:
            return NO;
            
        default:
            return YES;
    }
}

@end
