//
//  BBCSMPBackgroundPlaybackManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 20/08/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAirplayObserver.h"
#import "BBCSMPAudioManagerObserver.h"
#import "BBCSMPBackgroundObserver.h"
#import "BBCSMPBackgroundPlaybackManager.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPItem.h"
#import "BBCSMPState.h"
#import "BBCSMPAVType.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPControllable.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPDisplayCoordinatorProtocol.h"
#import "BBCSMPBackgroundStateProvider.h"

@interface BBCSMPBackgroundPlaybackManager () <BBCSMPItemObserver,
                                               BBCSMPStateObserver,
                                               BBCSMPBackgroundObserver,
                                               BBCSMPAirplayObserver,
                                               BBCSMPAudioManagerObserver>
@end

#pragma mark -

@implementation BBCSMPBackgroundPlaybackManager {
    __weak id<BBCSMP> _controllable;
    __weak id<BBCSMPDisplayCoordinatorProtocol> _displayCoordinator;
    BBCSMPBackgroundAction _backgroundAction;
    BBCSMPStateEnumeration _state;
    BOOL _hasVideo;
    BOOL _bluetoothActive;
    BOOL _background;
    BOOL _pictureInPictureActive;
    BOOL _airplayActive;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
       backgroundStateProvider:(id<BBCSMPBackgroundStateProvider>)backgroundStateProvider
            displayCoordinator:(id<BBCSMPDisplayCoordinatorProtocol>)displayCoordinator
{
    self = [super init];
    if (self) {
        _controllable = player;
        _displayCoordinator = displayCoordinator;
        _pictureInPictureActive = NO;
        
        [backgroundStateProvider addObserver:self];
        [player addObserver:self];
    }
    
    return self;
}

#pragma mark Public

- (BOOL)isAllowedToPlay
{
    return !_hasVideo || !_background || _airplayActive || _pictureInPictureActive;
}

#pragma mark BBCSMPBackgroundObserver

- (void)playerWillResignActive {}

- (void)playerEnteredBackgroundState
{
    if (!_background) {
        _background = YES;
        [self determineBackgroundInteractionStatus];
    }
}

- (void)playerEnteredForegroundState
{
    if (_background) {
        _background = NO;
    }
}

#pragma mark BBCSMPAudioManagerObserver

- (void)audioTransitionedToExternalSession
{
    _bluetoothActive = YES;
}

- (void)audioTransitionedToInternalSession
{
    _bluetoothActive = NO;
}

#pragma mark BBCSMPAirplayObserver

- (void)airplayActivationChanged:(NSNumber*)active
{
    if (_airplayActive && !active.boolValue) {
        [_controllable pause];
    }

    _airplayActive = active.boolValue;
}

- (void)airplayAvailabilityChanged:(NSNumber*)available
{
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _hasVideo = (playerItem && playerItem.metadata.avType == BBCSMPAVTypeVideo);

    if (playerItem && [playerItem respondsToSelector:@selector(actionOnBackground)]) {
        _backgroundAction = [playerItem actionOnBackground];
    }
    else {
        _backgroundAction = BBCSMPBackgroundActionDefault;
    }
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _state = state.state;

    if (_state == BBCSMPStateError) {
        [self determineBackgroundInteractionStatus];
    }
}

#pragma mark BBCSMPPictureInPictureAdapterDelegate

- (void)didStartPictureInPicture
{
    _pictureInPictureActive = YES;
    [self determineBackgroundInteractionStatus];
}

- (void)didStopPictureInPicture
{
    _pictureInPictureActive = NO;
    [self determineBackgroundInteractionStatus];
}

#pragma mark Private

- (void)determineBackgroundInteractionStatus
{
    BOOL playing = _state == BBCSMPStatePlaying || _state == BBCSMPStateBuffering;
    BOOL paused = _state == BBCSMPStatePaused;
    BOOL playingOrPaused = playing || paused;
    BOOL interactionContinues = playingOrPaused;
    
    switch (_backgroundAction) {
        case BBCSMPBackgroundActionPausePlayback: {
            if (!paused) {
                [_controllable pause];
                interactionContinues = NO;
            }
            break;
        }
        case BBCSMPBackgroundActionTeardownPlayer: {
            [_controllable stop];
            interactionContinues = NO;
            break;
        }
        case BBCSMPBackgroundActionDefault: {
            if (_state == BBCSMPStateError) {
                interactionContinues = NO;
            }
            else if ((_hasVideo && playingOrPaused && !_pictureInPictureActive && ![self isAirplayVideoCurrentlyActive] && ![self displayCoordinatorIndicatesExternalDisplayIsActive] && _background)) {
                [_controllable pause];
                interactionContinues = NO;
            }
            break;
        }
    }
}

- (BOOL)displayCoordinatorIndicatesExternalDisplayIsActive
{
    return _displayCoordinator && _displayCoordinator.playbackShouldContinueWhenBackgrounding;
}

- (BOOL)isAirplayVideoCurrentlyActive
{
    return _airplayActive && !_bluetoothActive;
}

@end
