//
//  BBCSMPFullscreenButtonPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/05/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPFullscreenButtonPresenter.h"
#import "BBCSMPFullscreenScene.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPNavigationCoordinator.h"
#import "BBCSMPState.h"
#import "BBCSMPBrand.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPIcon.h"

@interface BBCSMPFullscreenButtonPresenter () <BBCSMPFullscreenSceneDelegate,
                                               BBCSMPStateObserver,
                                               BBCSMPNavigationCoordinatorObserver>
@end

#pragma mark -

@implementation BBCSMPFullscreenButtonPresenter {
    __weak id<BBCSMPFullscreenScene> _scene;
    id<BBCSMPUIConfiguration> _configuration;
    BBCSMPNavigationCoordinator *_navigationCoordinator;
    BBCSMPPresentationMode _presentationMode;
    BBCSMPUserInteractionsTracer *_userInteractionsTracer;
    BOOL _fullscreen;
    BBCSMPStateEnumeration _playerState;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _scene = context.view.scenes.fullscreenButtonScene;
        _navigationCoordinator = context.navigationCoordinator;
        _configuration = context.configuration;
        _presentationMode = context.presentationMode;
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        _scene.fullscreenDelegate = self;
        _fullscreen = _presentationMode != BBCSMPPresentationModeEmbedded;
        
        [_scene hideFullScreenButton];
        
        BBCSMPBrand *brand = context.brand;
        BBCSMPAccessibilityIndex *accessibilityIndex = brand.accessibilityIndex;
        BBCSMPBrandingIcons *icons = brand.icons;
        icons.enterFullscreenIcon.colour = brand.foregroundColor;
        icons.leaveFullscreenIcon.colour = brand.foregroundColor;
        
        if (_fullscreen) {
            [_scene setFullscreenButtonAccessibilityLabel:[accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementLeaveFullscreenButton]];
            [_scene setFullscreenButtonAccessibilityHint:[accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementLeaveFullscreenButton]];
            [_scene renderFullscreenButtonIcon:icons.leaveFullscreenIcon];
        }
        else {
            [_scene setFullscreenButtonAccessibilityLabel:[accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementEnterFullscreenButton]];
            [_scene setFullscreenButtonAccessibilityHint:[accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementEnterFullscreenButton]];
            [_scene renderFullscreenButtonIcon:icons.enterFullscreenIcon];
        }
        
        [self updateFullscreenButtonVisibility];
        [context.player addObserver:self];
        [_navigationCoordinator addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPFullscreenScene

- (void)fullscreenSceneDidTapToggleFullscreenButton:(id<BBCSMPFullscreenScene>)fullscreenScene
{
    if (_fullscreen) {
        [_navigationCoordinator leaveFullscreen];
        [_userInteractionsTracer notifyObserversUsingSelector:@selector(leaveFullscreenButtonTapped)];
    }
    else {
        [_navigationCoordinator enterFullscreen];
        [_userInteractionsTracer notifyObserversUsingSelector:@selector(enterFullscreenButtonTapped)];
    }
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _playerState = state.state;
    [self updateFullscreenButtonVisibility];
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

#pragma mark Private

- (void)updateFullscreenButtonVisibility
{
    if ([self shouldPresentFullscreenButton]) {
        [_scene showFullScreenButton];
    }
    else {
        [_scene hideFullScreenButton];
    }
}

- (BOOL)shouldPresentFullscreenButton
{
    if(_presentationMode == BBCSMPPresentationModeFullscreenFromEmbedded) {
        return YES;
    }
    
    switch (_playerState) {
        case BBCSMPStateLoadingItem:
        case BBCSMPStateItemLoaded:
        case BBCSMPStatePreparingToPlay:
        case BBCSMPStatePlayerReady:
        case BBCSMPStatePlaying:
        case BBCSMPStateBuffering:
        case BBCSMPStatePaused:
            return _configuration.fullscreenEnabled &&
                   _presentationMode != BBCSMPPresentationModeFullscreen;
            
        default:
            return NO;
    }
}

@end
