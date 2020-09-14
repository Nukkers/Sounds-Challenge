//
//  BBCSMPAutoplayWhenViewWillAppear.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAutoplayWhenViewWillAppear.h"
#import "BBCSMPPlayer.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPViewControllerEventsCoordinator.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPState.h"

@interface BBCSMPAutoplayWhenViewWillAppear () <BBCSMPStateObserver,
                                                BBCSMPViewControllerLifecycleEventObserver>
@end

#pragma mark -

@implementation BBCSMPAutoplayWhenViewWillAppear {
    __weak id<BBCSMP> _player;
    BOOL _autoplayEnabled;
    BBCSMPStateEnumeration _playerState;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _player = context.player;
        _autoplayEnabled = context.configuration.autoplay;
        
        [context.presentationControllers.viewControllerLifecycleCoordinator addObserver:self];
        [_player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _playerState = state.state;
}

#pragma mark BBCSMPViewControllerLifecycleEventObserver

- (void)viewControllerWillAppear
{
    if(_autoplayEnabled && _playerState != BBCSMPStatePaused) {
        [_player play];
    }
}

- (void)viewControllerDidAppear
{
}

- (void)viewControllerWillDisappear
{
}

- (void)viewControllerDidDisappear
{
}

@end
