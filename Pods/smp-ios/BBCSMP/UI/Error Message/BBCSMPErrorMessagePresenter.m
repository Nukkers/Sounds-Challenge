
//  BBCSMPErrorMessagePresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPErrorMessagePresenter.h"
#import "BBCSMPErrorMessageScene.h"
#import "BBCSMPErrorObserver.h"
#import "BBCSMPPlaybackControlsScene.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPStatusBar.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPTitleBarScene.h"
#import "BBCSMPTransportControlsScene.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPlayCTAButtonScene.h"
#import "BBCSMPNavigationCoordinator.h"
#import "BBCSMPError.h"
#import "BBCSMPState.h"
#import "BBCSMPTime.h"
#import "BBCSMPCloseButtonScene.h"

@interface BBCSMPErrorMessagePresenter () <BBCSMPNavigationCoordinatorObserver,
                                           BBCSMPErrorMessageSceneDelegate,
                                           BBCSMPErrorObserver,
                                           BBCSMPStateObserver,
                                           BBCSMPTimeObserver>
@end

#pragma mark -

@implementation BBCSMPErrorMessagePresenter {
    __weak id<BBCSMP> _player;
    __weak id<BBCSMPErrorMessageScene> _errorMessageScene;
    __weak id<BBCSMPTitleBarScene> _titleBarScene;
    __weak id<BBCSMPPlaybackControlsScene> _playbackControlsScene;
    __weak id<BBCSMPTransportControlsScene> _transportControlsScene;
    __weak id<BBCSMPStatusBar> _statusBar;
    __weak id<BBCSMPPlayCTAButtonScene> _CTAButtonScene;
    __weak id<BBCSMPCloseButtonScene> _closeButtonScene;
    NSTimeInterval _currentOffset;
    BBCSMPPresentationMode _presentationMode;
    BOOL _currentlyWithinErrorState;
    BOOL _fullscreen;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _player = context.player;
        _errorMessageScene = context.view.scenes.errorMessageScene;
        _titleBarScene = context.view.scenes.titleBarScene;
        _playbackControlsScene = context.view.scenes.playbackControlsScene;
        _transportControlsScene = context.view.scenes.transportControlsScene;
        _statusBar = context.statusBar;
        _CTAButtonScene = context.view.scenes.playCTAButtonScene;
        _presentationMode = context.presentationMode;
        _closeButtonScene = context.view.scenes.closeButtonScene;
        
        _errorMessageScene.errorMessageDelegate = self;
        [context.navigationCoordinator addObserver:self];
        [context.player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPNavigationCoordinatorObserver

- (void)didLeaveFullscreen
{
    _fullscreen = NO;
}

- (void)didEnterFullscreen
{
    _fullscreen = YES;
}

#pragma mark BBCSMPErrorMessageSceneDelegate

- (void)errorMessageSceneDidTapRetryButton:(id<BBCSMPErrorMessageScene>)errorMessageScene
{
    [_playbackControlsScene show];
    [_titleBarScene show];
    [_errorMessageScene hide];
    [_statusBar showStatusBar];
    
    if (_presentationMode == BBCSMPPresentationModeFullscreen) {
        [_closeButtonScene show];
    }
    
    [_player play];
}

- (void)errorMessageSceneDidTapDismissButton:(id<BBCSMPErrorMessageScene>)errorMessageScene
{
    [_playbackControlsScene show];
    [_titleBarScene show];
    [_errorMessageScene hide];
    [_statusBar showStatusBar];
    [_CTAButtonScene appear];
    
    if (_presentationMode == BBCSMPPresentationModeFullscreen) {
        [_closeButtonScene show];
    }
}

#pragma mark BBCSMPErrorObserver

- (void)errorOccurred:(BBCSMPError*)error
{
    if(_fullscreen && _presentationMode == BBCSMPPresentationModeEmbedded) {
        [_playbackControlsScene show];
        [_titleBarScene show];
        [_CTAButtonScene appear];
        return;
    }
    
    _currentlyWithinErrorState = YES;

    [_errorMessageScene show];
    [_errorMessageScene presentErrorDescription:error.error.localizedDescription];
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    if (_currentlyWithinErrorState) {
        [_errorMessageScene hide];
    }

    _currentlyWithinErrorState = state.state == BBCSMPStateError;
}

#pragma mark BBCSMPTimeObserver

- (void)timeChanged:(BBCSMPTime*)time
{
    _currentOffset = time.seconds;
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime
{
    _currentOffset = toTime.seconds;
}

- (void)durationChanged:(__unused BBCSMPDuration*)duration {}
- (void)seekableRangeChanged:(__unused BBCSMPTimeRange*)range {}
- (void)playerRateChanged:(__unused float)newPlayerRate{}

@end
