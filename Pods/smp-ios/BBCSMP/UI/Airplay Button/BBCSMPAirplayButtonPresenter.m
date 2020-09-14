//
//  BBCSMPAirplayButtonPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAirplayButtonPresenter.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPAirplayButtonScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPAirplayObserver.h"
#import "BBCSMPState.h"

@interface BBCSMPAirplayButtonPresenter () <BBCSMPAirplayObserver, BBCSMPStateObserver>
@end

#pragma mark -

@implementation BBCSMPAirplayButtonPresenter {
    __weak id<BBCSMPAirplayButtonScene> _airplayButtonScene;
    BOOL _airplayEnabled;
    BOOL _airplayAvailable;
    BBCSMPStateEnumeration _playerState;
    BBCSMPPresentationMode _presentationMode;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _airplayEnabled = [context.configuration airplayEnabled];
        _airplayButtonScene = context.view.scenes.airplayButtonScene;
        _presentationMode = context.presentationMode;
        [_airplayButtonScene hideAirplayButton];
        
        [context.player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPAirplayObserver

- (void)airplayAvailabilityChanged:(NSNumber*)available
{
    _airplayAvailable = available.boolValue;
    [self updateAirplayButtonVisibilityState];
}

- (void)airplayActivationChanged:(NSNumber*)active {}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _playerState = state.state;
    [self updateAirplayButtonVisibilityState];
}

#pragma mark Private

- (void)updateAirplayButtonVisibilityState
{
    if([self shouldShowAirplayButton]) {
        [_airplayButtonScene showAirplayButton];
    }
    else {
        [_airplayButtonScene hideAirplayButton];
    }
}

- (BOOL)shouldShowAirplayButton
{
    return [self shouldShowAirplayButtonForCurrentState] &&
           _presentationMode != BBCSMPPresentationModeFullscreenFromEmbedded &&
           _airplayEnabled &&
           _airplayAvailable;
}

- (BOOL)shouldShowAirplayButtonForCurrentState
{
    return _playerState != BBCSMPStateIdle &&
           _playerState != BBCSMPStateLoadingItem &&
           _playerState != BBCSMPStateItemLoaded &&
           _playerState != BBCSMPStateError &&
           _playerState != BBCSMPStateEnded;
}

@end
