//
//  BBCSMPChromeVisibilityCoordinator.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityChromeSuppression.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPActivityScene.h"
#import "BBCSMPAirplayObserver.h"
#import "BBCSMPChromeVisibilityCoordinator.h"
#import "BBCSMPErrorObserver.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPScrubbingChromeSuppression.h"
#import "BBCSMPState.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPSuppressChromeWhenEnded.h"
#import "BBCSMPSuppressChromeWhileAirplaying.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPTimerProtocol.h"
#import "BBCSMPTransportControlsScene.h"
#import "BBCSMPViewControllerEventsCoordinator.h"
#import "BBCSMPStatusBar.h"
#import "BBCSMPItem.h"
#import "BBCSMPItemMetadata.h"

static NSString* const kBBCSMPTransportControlsInteractionSuppressionReason = @"Interacting with transport controls";
static NSString* const kBBCSMPControlsVisibleForStateSuppressionReason = @"Playback Stopping";
static NSString* const kBBCSMPAudioContentSuppressionReason = @"Audio Content";

@interface BBCSMPChromeVisibilityCoordinator () <BBCSMPActivitySceneDelegate,
    BBCSMPTransportControlsInteractivityDelegate,
    BBCSMPItemObserver,
    BBCSMPStateObserver,
    BBCSMPErrorObserver,
    BBCSMPViewControllerLifecycleEventObserver>
@end

#pragma mark -

@implementation BBCSMPChromeVisibilityCoordinator {
    BBCSMPAccessibilityChromeSuppression* _accessibilityChromeSuppression;
    BBCSMPScrubbingChromeSuppression* _scrubbingChromeSupression;
    BBCSMPSuppressChromeWhenEnded* _suppressWhenEnded;
    BBCSMPSuppressChromeWhileAirplaying* _suppressWhileAirplaying;
    
    __weak id<BBCSMPStatusBar> _statusBar;
    NSMutableSet<id<BBCSMPChromeVisibilityObserver> >* _visibilityObservers;
    NSTimeInterval _inactivityPeriod;
    id<BBCSMPTimerFactoryProtocol> _timerFactory;
    id<BBCSMPTimerProtocol> _inactivityTimer;
    id<BBCSMPItem> _item;
    NSMutableSet<NSString*>* _suppressionReasons;
    BBCSMPState* _state;
    BOOL _playbackStarted;
    BOOL _currentlyWithinErrorState;
    BOOL _chromeVisible;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id <BBCSMP>)player
     permittedInactivityPeriod:(NSTimeInterval)inactivityPeriod
                        scenes:(id<BBCSMPPlayerScenes>)scenes
            scrubberController:(BBCSMPScrubberController *)scrubberController
                  timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
viewControllerLifecycleCoordinator:(BBCSMPViewControllerEventsCoordinator*)viewControllerLifecycleCoordinator
   accessibilityStateProviding:(id<BBCSMPAccessibilityStateProviding>)accessibilityStateProviding
                     statusBar:(id<BBCSMPStatusBar>)statusBar
{
    self = [super init];
    if (self) {
        _visibilityObservers = [NSMutableSet set];
        _inactivityPeriod = inactivityPeriod;
        _timerFactory = timerFactory;
        _suppressionReasons = [NSMutableSet set];
        scenes.activityScene.activitySceneDelegate = self;
        scenes.transportControlsScene.interactivityDelegate = self;
        _currentlyWithinErrorState = NO;
        _chromeVisible = YES;
        _statusBar = statusBar;
        
        [viewControllerLifecycleCoordinator addObserver:self];
        
        _accessibilityChromeSuppression = [[BBCSMPAccessibilityChromeSuppression alloc] initWithChromeSuppression:self scenes:scenes accessibilityStateProviding:accessibilityStateProviding];
        _scrubbingChromeSupression = [[BBCSMPScrubbingChromeSuppression alloc] initWithChromeSuppression:self scrubberController:scrubberController];
        _suppressWhenEnded = [[BBCSMPSuppressChromeWhenEnded alloc] initWithChromeSuppression:self player:player];
        _suppressWhileAirplaying = [[BBCSMPSuppressChromeWhileAirplaying alloc] initWithChromeSuppression:self player:player];

        [player addObserver:self];
    }

    return self;
}

#pragma mark Overriddes

- (void)setDelegate:(id<BBCSMPChromeVisibilityCoordinatorDelegate>)delegate
{
    _delegate = delegate;

    if (_chromeVisible) {
        [_delegate chromeVisibilityCoordinatorDidResolveChromeShouldAppear:self];
    }
    else {
        [_delegate chromeVisibilityCoordinatorDidResolveChromeShouldDisappear:self];
    }
}

#pragma mark BBCSMPChromeSupression

- (void)suppressControlAutohideForReason:(NSString*)reason
{
    [_suppressionReasons addObject:reason];
    [self makeChromeVisible];

    if (_inactivityTimer) {
        [self stopInactivityTimer];
    }
}

- (void)stopSuppressingControlAutohideForReason:(NSString*)reason
{
    if (![_suppressionReasons member:reason]) {
        return;
    }

    [_suppressionReasons removeObject:reason];
    [self startInactivityTimerIfAutosuppressionDisabled];
}

#pragma mark BBCSMPChromeVisibility

- (void)addVisibilityObserver:(id<BBCSMPChromeVisibilityObserver>)visibilityObserver
{
    [_visibilityObservers addObject:visibilityObserver];
}

#pragma mark BBCSMPActivitySceneDelegate

- (void)activitySceneDidReceiveInteraction:(id<BBCSMPActivityScene>)activityScene
{
    if ([self shouldPermitActivitySceneInteractions]) {
        [self toggleChromeVisibility];
    }
}

#pragma mark BBCSMPTransportControlsInteractivityDelegate

- (void)transportControlsSceneInteractionsDidBegin:(id<BBCSMPTransportControlsScene>)transportControlsScene
{
    [self suppressControlAutohideForReason:kBBCSMPTransportControlsInteractionSuppressionReason];
}

- (void)transportControlsSceneInteractionsDidFinish:(id<BBCSMPTransportControlsScene>)transportControlsScene
{
    [self stopSuppressingControlAutohideForReason:kBBCSMPTransportControlsInteractionSuppressionReason];
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _item = playerItem;

    if (_item.metadata.avType == BBCSMPAVTypeAudio) {
        [self suppressControlAutohideForReason:kBBCSMPAudioContentSuppressionReason];
    }
    else {
        [self stopSuppressingControlAutohideForReason:kBBCSMPAudioContentSuppressionReason];
    }
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _state = state;
    _currentlyWithinErrorState = state.state == BBCSMPStateError;

    if (!_playbackStarted) {
        _playbackStarted = state.state == BBCSMPStatePlaying;
        [self startInactivityTimerIfAutosuppressionDisabled];
    }

    if (state.state == BBCSMPStateStopping || state.state == BBCSMPStateIdle) {
        [self suppressControlAutohideForReason:kBBCSMPControlsVisibleForStateSuppressionReason];
    }
    else {
        [self stopSuppressingControlAutohideForReason:kBBCSMPControlsVisibleForStateSuppressionReason];
    }
}

#pragma mark BBCSMPErrorObserver

- (void)errorOccurred:(BBCSMPError*)error
{
    [self stopInactivityTimer];

    _currentlyWithinErrorState = YES;
    _playbackStarted = NO;
}

#pragma mark BBCSMPViewControllerLifecycleEventObserver

- (void)viewControllerWillAppear {}
- (void)viewControllerDidAppear {}
- (void)viewControllerWillDisappear {}

- (void)viewControllerDidDisappear
{
    [self stopInactivityTimer];
}

#pragma mark Private

- (void)startInactivityTimerIfAutosuppressionDisabled
{
    if (!_inactivityTimer && _suppressionReasons.count == 0) {
        [self startInactivityTimer];
    }
}

- (void)startInactivityTimer
{
    if (!_inactivityTimer && _playbackStarted) {
        _inactivityTimer = [_timerFactory timerWithInterval:_inactivityPeriod target:self selector:@selector(inactivityTimerExpired)];
    }
}

- (void)stopInactivityTimer
{
    [_inactivityTimer stop];
    _inactivityTimer = nil;
}

- (void)inactivityTimerExpired
{
    _inactivityTimer = nil;
    [self makeChromeHidden];
}

- (void)makeChromeVisible
{
    [_delegate chromeVisibilityCoordinatorDidResolveChromeShouldAppear:self];
    [_visibilityObservers makeObjectsPerformSelector:@selector(chromeDidBecomeVisible)];
    _chromeVisible = YES;
}

- (void)makeChromeHidden
{
    [_delegate chromeVisibilityCoordinatorDidResolveChromeShouldDisappear:self];
    [_visibilityObservers makeObjectsPerformSelector:@selector(chromeDidBecomeHidden)];
    _chromeVisible = NO;
}

- (BOOL)shouldPermitActivitySceneInteractions
{
    return [self activitySceneInteractableForCurrentState] && ![self chromeVisibilityChangesCurrentlySuppressed];
}

- (BOOL)activitySceneInteractableForCurrentState
{
    return !(_currentlyWithinErrorState || _state.state == BBCSMPStateEnded);
}

- (BOOL)chromeVisibilityChangesCurrentlySuppressed
{
    return _suppressionReasons.count > 0 && ![self assistiveTechnologyActive];
}

- (BOOL)assistiveTechnologyActive
{
    return [_suppressionReasons member:kBBCSMPVoiceoverActiveReason] ||
           [_suppressionReasons member:kBBCSMPSwitchControlsActiveReason];
}

- (void)toggleChromeVisibility
{
    if (_chromeVisible) {
        [self stopInactivityTimer];
        [self makeChromeHidden];
    }
    else {
        if(_suppressionReasons.count == 0) {
            [self startInactivityTimer];
        }
        
        [self makeChromeVisible];
    }
}

@end
