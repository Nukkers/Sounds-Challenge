//
//  BBCSMPSubtitlesButtonPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 03/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSubtitlesButtonPresenter.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPSubtitlesButtonScene.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPState.h"

@interface BBCSMPSubtitlesButtonPresenter () <BBCSMPEnableSubtitlesButtonSceneDelegate,
                                              BBCSMPDisableSubtitlesButtonSceneDelegate,
                                              BBCSMPSubtitleObserver,
                                              BBCSMPStateObserver>
@end

#pragma mark -

@implementation BBCSMPSubtitlesButtonPresenter {
    __weak id<BBCSMPEnableSubtitlesButtonScene> _enableSubtitlesButtonScene;
    __weak id<BBCSMPDisableSubtitlesButtonScene> _disableSubtitlesButtonScene;
    __weak id<BBCSMP> _player;
    id<BBCSMPUIConfiguration> _configuration;
    BBCSMPUserInteractionsTracer *_userInteractionsTracer;
    BOOL _subtitlesEnabledFromConfiguration;
    BOOL _subtitlesActive;
    BOOL _subtitlesAvailable;
    BBCSMPStateEnumeration _playerState;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _player = context.player;
        _configuration = context.configuration;
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        _subtitlesEnabledFromConfiguration = [_configuration subtitlesEnabled];
        _enableSubtitlesButtonScene = context.view.scenes.enableSubtitlesScene;
        _disableSubtitlesButtonScene = context.view.scenes.disableSubtitlesScene;
        _enableSubtitlesButtonScene.enableSubtitlesDelegate = self;
        _disableSubtitlesButtonScene.disableSubtitlesDelegate = self;
        
        if(!_subtitlesEnabledFromConfiguration) {
            [_player deactivateSubtitles];
        }
        
        [_player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPEnableSubtitlesButtonSceneDelegate

- (void)enableSubtitlesButtonSceneDidReceiveTap:(id<BBCSMPEnableSubtitlesButtonScene>)enableSubtitlesScene
{
    [_player activateSubtitles];
    [_userInteractionsTracer notifyObserversUsingSelector:@selector(activateSubtitlesButtonTapped)];
}

#pragma mark BBCSMPDisableSubtitlesButtonSceneDelegate

- (void)disableSubtitlesButtonSceneDidReceiveTap:(id<BBCSMPDisableSubtitlesButtonScene>)disableSubtitlesScene
{
    [_player deactivateSubtitles];
    [_userInteractionsTracer notifyObserversUsingSelector:@selector(deactivateSubtitlesButtonTapped)];
}

#pragma mark BBCSMPSubtitlesObserver

- (void)subtitleAvailabilityChanged:(NSNumber*)available
{
    _subtitlesAvailable = available.boolValue;
    [self updateSubtitleButtonVisibility];
}

- (void)subtitleActivationChanged:(NSNumber*)active
{
    _subtitlesActive = active.boolValue;
    
    if(_subtitlesActive) {
        [_enableSubtitlesButtonScene hideEnableSubtitlesButton];
        [_disableSubtitlesButtonScene showDisableSubtitlesButton];
    }
    else {
        [_disableSubtitlesButtonScene hideDisableSubtitlesButton];
        [_enableSubtitlesButtonScene showEnableSubtitlesButton];
    }
}

- (void)styleDictionaryUpdated:(NSDictionary*)styleDictionary baseStyleKey:(NSString *)baseStyleKey {}
- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle*>*)subtitles {}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    _playerState = state.state;
    [self updateSubtitleButtonVisibility];
}

#pragma mark Private

- (void)updateSubtitleButtonVisibility
{
    if([self shouldShowSubtitlesOptions]) {
        [self showAppropriateSubtitlesButtonForCurrentActivation];
    }
    else {
        [_enableSubtitlesButtonScene hideEnableSubtitlesButton];
        [_disableSubtitlesButtonScene hideDisableSubtitlesButton];
    }
}

- (void)showAppropriateSubtitlesButtonForCurrentActivation
{
    if(_subtitlesActive) {
        [_disableSubtitlesButtonScene showDisableSubtitlesButton];
    }
    else {
        [_enableSubtitlesButtonScene showEnableSubtitlesButton];
    }
}

- (BOOL)shouldShowSubtitlesOptions
{
    return _subtitlesEnabledFromConfiguration &&
           _subtitlesAvailable &&
           _playerState != BBCSMPStateEnded &&
           _playerState != BBCSMPStateError;
}

@end
