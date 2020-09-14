//
//  BBCSMPVolumePresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPVolumePresenter.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPVolumeScene.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPAudioManagerObserver.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPVolumeObserver.h"
#import "BBCSMPState.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPVolumePresenter () <BBCSMPAudioManagerObserver,
                                    BBCSMPVolumeObserver,
                                    BBCSMPPlaybackStateObserver>
@end

#pragma mark -

@implementation BBCSMPVolumePresenter {
    __weak id<BBCSMPVolumeScene> _volumeScene;
    BOOL _volumeSliderHiddenFromConfiguration;
    BBCSMPUserInteractionsTracer *_userInteractionsTracer;
    BBCSMPStateEnumeration _state;
    id<SMPPlaybackState> _playbackState;

    BOOL _volumeSliderCurrentlyVisible;
    BOOL _spaceCurrentlyRestricted;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _volumeScene = context.view.scenes.volumeScene;
        _volumeSliderHiddenFromConfiguration = context.configuration.volumeSliderHidden;
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        [context.player addObserver:self];
        [context.player addStateObserver:self];
        
        [self updateVolumeSceneVisibility];
        [_userInteractionsTracer notifyObserversUsingSelector:@selector(volumeSliderHidden)];
    }
    
    return self;
}

#pragma mark BBCSMPAudioManagerObserver

- (void)audioTransitionedToExternalSession
{
     [_volumeScene hideVolumeSlider];
}

- (void)audioTransitionedToInternalSession
{
    [self updateVolumeSceneVisibility];
}

#pragma mark BBCSMPVolumeObserver

- (void)playerMuteStateChanged:(NSNumber*)muted { }

- (void)playerVolumeChanged:(NSNumber*)volume
{
    [_volumeScene updateVolume:volume.floatValue];
}

#pragma mark Private

- (void)updateVolumeSceneVisibility
{
    BOOL visible = [self shouldShowVolumeSlider];
    SEL tracerSelector;
    if (visible) {
        [_volumeScene showVolumeSlider];
        tracerSelector = @selector(volumeSliderDisplayed);
    }
    else {
        [_volumeScene hideVolumeSlider];
        tracerSelector = @selector(volumeSliderHidden);
    }
    
    if(_volumeSliderCurrentlyVisible ^ visible) {
        [_userInteractionsTracer notifyObserversUsingSelector:tracerSelector];
    }
    
    _volumeSliderCurrentlyVisible = visible;
}

- (BOOL)shouldShowVolumeSlider
{
    return (!_volumeSliderHiddenFromConfiguration)
    && [self shouldShowVolumeSliderForCurrentState]
    && (!_spaceCurrentlyRestricted);
}

- (BOOL)shouldShowVolumeSliderForCurrentState
{
    id playbackState = _playbackState;

    return [playbackState isKindOfClass:[SMPPlaybackStatePlaying class]] ||
            [playbackState isKindOfClass:[SMPPlaybackStateLoading class]] ||
            [playbackState isKindOfClass:[SMPPlaybackStatePaused class]];
}

- (void)state:(id<SMPPlaybackState> _Nonnull)state {
    _playbackState = state;
    [self updateVolumeSceneVisibility];
}

-(void)spaceRestricted {
    _spaceCurrentlyRestricted = YES;
    [self updateVolumeSceneVisibility];
}

-(void)spaceAvailable {
    _spaceCurrentlyRestricted = NO;
    [self updateVolumeSceneVisibility];
}

@end
