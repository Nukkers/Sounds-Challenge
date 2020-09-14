//
//  BBCSMPPictureInPictureButtonPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPictureInPictureButtonPresenter.h"
#import "BBCSMPPictureInPictureButtonScene.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPAirplayObserver.h"
#import "BBCSMPPictureInPictureAvailabilityObserver.h"
#import "BBCSMPPictureInPictureControllerObserver.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPBrand.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPState.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPIcon.h"
#import "BBCSMPAccessibilityIndex.h"

@interface BBCSMPPictureInPictureButtonPresenter () <BBCSMPAirplayObserver,
                                                     BBCSMPPictureInPictureAvailabilityObserver,
                                                     BBCSMPPictureInPictureButtonSceneDelegate,
                                                     BBCSMPPictureInPictureControllerObserver,
                                                     BBCSMPStateObserver>
@end

#pragma mark -

@implementation BBCSMPPictureInPictureButtonPresenter {
    __weak id<BBCSMP> _player;
    __weak id<BBCSMPPictureInPictureButtonScene> _pictureInPictureButtonScene;
    id<BBCSMPUIConfiguration> _configuration;
    BBCSMPBrand *_brand;
    BBCSMPUserInteractionsTracer *_userInteractionsTracer;
    BOOL _pictureInPictureAvailable;
    BOOL _pictureInPictureActive;
    BOOL _airplayActive;
    BBCSMPStateEnumeration _state;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _player = context.player;
        _pictureInPictureButtonScene = context.view.scenes.pictureInPictureButtonScene;
        _configuration = context.configuration;
        _brand = context.brand;
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        _pictureInPictureButtonScene.pictureInPictureSceneDelegate = self;
        [self applyEnterPictureInPictureAccessibilityTerms];
        
        [context.player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPAirplayObserver

- (void)airplayActivationChanged:(NSNumber *)active
{
    _airplayActive = active.boolValue;
    [self updatePictureInPictureVisibility];
}

- (void)airplayAvailabilityChanged:(NSNumber *)available {}

#pragma mark BBCSMPPictureInPictureAvailabilityObserver

- (void)pictureInPictureAvailabilityDidChange:(BOOL)pictureInPictureAvailable
{
    _pictureInPictureAvailable = pictureInPictureAvailable;
    [self updatePictureInPictureVisibility];
}

#pragma mark BBCSMPPictureInPictureButtonSceneDelegate

- (void)pictureInPictureSceneDidTapToggle:(id<BBCSMPPictureInPictureButtonScene>)pictureInPictureButtonScene
{
    if(_pictureInPictureActive) {
        [_player exitPictureInPicture];
        [_userInteractionsTracer notifyObserversUsingSelector:@selector(stopPictureInPictureTapped)];
    }
    else {
        [_player transitionToPictureInPicture];
        [_userInteractionsTracer notifyObserversUsingSelector:@selector(startPictureInPictureTapped)];
    }
}

#pragma mark BBCSMPPictureInPictureControllerObserver

- (void)didStartPictureInPicture
{
    _pictureInPictureActive = YES;
    [self renderIcon:_brand.icons.exitPictureInPictureIcon];
    [self applyLeavePictureInPictureAccessibilityTerms];
}

- (void)didStopPictureInPicture
{
    _pictureInPictureActive = NO;
    [self renderIcon:_brand.icons.enterPictureInPictureIcon];
    [self applyEnterPictureInPictureAccessibilityTerms];
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _state = state.state;
    [self updatePictureInPictureVisibility];
}

#pragma mark Private

- (void)updatePictureInPictureVisibility
{
    if([self shouldShowPictureInPictureIcon]) {
        [_pictureInPictureButtonScene showPictureInPictureButton];
    }
    else {
        [_pictureInPictureButtonScene hidePictureInPictureButton];
    }
}

- (BOOL)shouldShowPictureInPictureIcon
{
    return [self canShowPictureInPictureIconForCurrentState] &&
           [_configuration pictureInPictureEnabled] &&
           _pictureInPictureAvailable &&
           !_airplayActive;
}

- (BOOL)canShowPictureInPictureIconForCurrentState
{
    return _state == BBCSMPStatePlaying ||
           _state == BBCSMPStatePaused ||
           _state == BBCSMPStateBuffering;
}

- (void)renderIcon:(id<BBCSMPIcon>)icon
{
    icon.colour = _brand.foregroundColor;
    [_pictureInPictureButtonScene renderIcon:icon];
}

- (void)applyEnterPictureInPictureAccessibilityTerms
{
    [self applyAccessibilityTerm:[_brand.accessibilityIndex termForAccessibilityElement:BBCSMPAccessibilityElementEnterPictureInPictureButton]];
}

- (void)applyLeavePictureInPictureAccessibilityTerms
{
    [self applyAccessibilityTerm:[_brand.accessibilityIndex termForAccessibilityElement:BBCSMPAccessibilityElementLeavePictureInPictureButton]];
}

- (void)applyAccessibilityTerm:(BBCSMPAccessibilityTerm *)term
{
    [_pictureInPictureButtonScene setPictureInPictureButtonAccessibilityLabel:term.label];
    [_pictureInPictureButtonScene setPictureInPictureButtonAccessibilityHint:term.hint];
}

@end
