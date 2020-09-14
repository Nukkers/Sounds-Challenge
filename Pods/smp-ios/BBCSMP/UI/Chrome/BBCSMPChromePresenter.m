//
//  BBCSMPChromePresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromePresenter.h"
#import "BBCSMPChromeVisibilityCoordinator.h"
#import "BBCSMPOverlayScene.h"
#import "BBCSMPPlaybackControlsScene.h"
#import "BBCSMPStatusBar.h"
#import "BBCSMPTitleBarScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPHomeIndicatorScene.h"
#import "BBCSMPDeviceTraits.h"

@interface BBCSMPChromePresenter () <BBCSMPChromeVisibilityCoordinatorDelegate>
@end

#pragma mark -

@implementation BBCSMPChromePresenter {
    id<BBCSMPUIConfiguration> _configuration;
    id<BBCSMPDeviceTraits> _deviceTraits;
    __weak id<BBCSMPStatusBar> _statusBar;
    __weak id<BBCSMPHomeIndicatorScene> _homeIndicator;
    __weak id<BBCSMPTitleBarScene> _titleBarScene;
    __weak id<BBCSMPPlaybackControlsScene> _playbackControlsScene;
    __weak id<BBCSMPOverlayScene> _overlayScene;
    BBCSMPPresentationMode _presentationMode;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _configuration = context.configuration;
        _statusBar = context.statusBar;
        _homeIndicator = context.homeIndicator;
        _titleBarScene = context.view.scenes.titleBarScene;
        _playbackControlsScene = context.view.scenes.playbackControlsScene;
        _overlayScene = context.view.scenes.overlayScene;
        _presentationMode = context.presentationMode;
        _deviceTraits = context.deviceTraits;
        context.presentationControllers.chromeVisibilityCoordinator.delegate = self;
        
        [_homeIndicator disableHomeIndicatorAutohiding];
        [self updateHomeIndicatorIfAvailable];
    }

    return self;
}

#pragma mark BBCSMPChromeSuppressorDelegate

- (void)chromeVisibilityCoordinatorDidResolveChromeShouldAppear:(BBCSMPChromeVisibilityCoordinator*)chromeSuppressor
{
    [_playbackControlsScene show];
    [_statusBar showStatusBar];

    if ([_configuration titleBarEnabled] || _presentationMode == BBCSMPPresentationModeFullscreen) {
        [_titleBarScene show];
    }
    else {
        [_titleBarScene hide];
    }

    [_overlayScene show];
    [_homeIndicator disableHomeIndicatorAutohiding];
    [self updateHomeIndicatorIfAvailable];
}

- (void)chromeVisibilityCoordinatorDidResolveChromeShouldDisappear:(BBCSMPChromeVisibilityCoordinator*)chromeSuppressor
{
    [_titleBarScene hide];
    [_playbackControlsScene hide];
    [_statusBar hideStatusBar];
    [_overlayScene hide];
    [_homeIndicator enableHomeIndicatorAutohiding];
    [self updateHomeIndicatorIfAvailable];
}

#pragma mark Private

- (void)updateHomeIndicatorIfAvailable
{
    if(_deviceTraits.homeIndicatorAvailable) {
        [_homeIndicator updateHomeIndicatorAutoHiddenState];
    }
}

@end
