//
//  BBCSMPTransportControlsPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPItemObserver.h"
#import "BBCSMPPictureInPictureControllerObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPTransportControlsPresenter.h"
#import "BBCSMPTransportControlsScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPUserInteractionObserver.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPPlayButtonScene.h"
#import "BBCSMPPauseButtonScene.h"
#import "BBCSMPStopButtonScene.h"
#import "BBCSMPVolumeScene.h"
#import "BBCSMPState.h"
#import "BBCSMPItem.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPBrand.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPIcon.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPStateObservable.h"
#import "BBCSMPUnpreparedStateListener.h"

@interface BBCSMPTransportControlsPresenter () <BBCSMPItemObserver,
BBCSMPPictureInPictureControllerObserver,
BBCSMPStateObserver,
BBCSMPSubtitleObserver,
BBCSMPTimeObserver,
BBCSMPPlayButtonSceneDelegate,
BBCSMPPauseButtonSceneDelegate,
BBCSMPStopButtonSceneDelegate,
BBCSMPPreloadMetadataObserver,
BBCSMPUnpreparedStateListener,
BBCSMPTransportControlsViewSpaceDelegate>
@end

#pragma mark -

@implementation BBCSMPTransportControlsPresenter {
    __weak id<BBCSMP> _player;
    __weak id<BBCSMPTransportControlsScene> _transportControlsScene;
    __weak id<BBCSMPPlayButtonScene> _playButtonScene;
    __weak id<BBCSMPPauseButtonScene> _pauseButtonScene;
    __weak id<BBCSMPStopButtonScene> _stopButtonScene;
    __weak id<BBCSMPTransportControlsSpaceObserver> _transportControlSpaceObserver;
    id<BBCSMPUIConfiguration> _configuration;
    BBCSMPStateEnumeration _state;
    BOOL _live;
    BOOL _liveScrubbable;
    BBCSMPUserInteractionsTracer* _userInteractionsTracer;
    BOOL _subtitlesActive;
    BBCSMPPresentationMode _presentationMode;
    BOOL _pictureInPictureActive;
    NSDictionary<NSNumber *, id<BBCSMPIcon>> *_avTypesToIcons;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context transportControlSpaceObserver:(id<BBCSMPTransportControlsSpaceObserver>)transportControlSpaceObserver
{
    self = [super init];
    if (self) {
        _player = context.player;
        _transportControlSpaceObserver = transportControlSpaceObserver;
        _configuration = context.configuration;
        _transportControlsScene = context.view.scenes.transportControlsScene;
        _transportControlsScene.spaceDelegate = self;
        _playButtonScene = context.view.scenes.playButtonScene;
        _playButtonScene.playButtonDelegate = self;
        _pauseButtonScene = context.view.scenes.pauseButtonScene;
        _pauseButtonScene.pauseButtonDelegate = self;
        _stopButtonScene = context.view.scenes.stopButtonScene;
        _stopButtonScene.stopButtonDelegate = self;
        _userInteractionsTracer = context.presentationControllers.userInteractionsTracer;
        _presentationMode = context.presentationMode;

        BBCSMPBrand *brand = context.brand;
        BBCSMPAccessibilityIndex *accessibilityIndex = brand.accessibilityIndex;
        [_playButtonScene setPlayButtonAccessibilityLabel:[accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementPlayButton]];
        [_playButtonScene setPlaybuttonAccessibilityHint:[accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementPlayButton]];
        [_pauseButtonScene setPauseButtonAccessibilityLabel:[accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementPauseButton]];
        [_pauseButtonScene setPauseButtonAccessibilityHint:[accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementPauseButton]];
        [_stopButtonScene setStopButtonAccessibilityLabel:[accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementStopButton]];
        [_stopButtonScene setStopButtonAccessibilityHint:[accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementStopButton]];

        _avTypesToIcons = @{@(BBCSMPAVTypeAudio) : brand.icons.audioPlayIcon,
                            @(BBCSMPAVTypeVideo) : brand.icons.videoPlayIcon };

        BBCSMPBrandingIcons *icons = brand.icons;
        [_playButtonScene setPlayButtonIcon:icons.videoPlayIcon];
        [_pauseButtonScene setPauseButtonIcon:icons.pauseIcon];
        [_stopButtonScene setStopButtonIcon:icons.stopIcon];

        [_playButtonScene setPlayButtonHighlightColor:brand.highlightColor];

        icons.videoPlayIcon.colour = brand.foregroundColor;
        icons.pauseIcon.colour = brand.foregroundColor;
        icons.stopIcon.colour = brand.foregroundColor;
        icons.audioPlayIcon.colour = brand.foregroundColor;

        [context.player addObserver:self];
        [context.player addUnpreparedStateListener:self];
    }

    return self;
}

#pragma mark BBCSMPItemObserver

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    _live = playerItem.metadata.streamType == BBCSMPStreamTypeSimulcast;
    [_playButtonScene setPlayButtonIcon:_avTypesToIcons[@(playerItem.metadata.avType)]];
    [self updatePlayActionButton];
}

#pragma mark BBCSMPPictureInPictureControllerObserver

- (void)didStartPictureInPicture
{
    _pictureInPictureActive = YES;
}

- (void)didStopPictureInPicture
{
    _pictureInPictureActive = NO;
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    _state = state.state;
    [self updatePlayActionButton];
}

#pragma mark BBCSMPSubtitleObserver

- (void)subtitleAvailabilityChanged:(NSNumber*)available
{
}

- (void)subtitleActivationChanged:(NSNumber*)active
{
    _subtitlesActive = active.boolValue;
}

- (void)styleDictionaryUpdated:(NSDictionary*)styleDictionary baseStyleKey:(NSString*)baseStyleKey
{
}

- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle*>*)subtitles
{
}

#pragma mark BBCSMPTimeObserver

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
    _liveScrubbable = range.durationMeetsMinimumLiveRewindRequirement;
    [self updatePlayActionButton];
}

- (void)timeChanged:(BBCSMPTime*)time
{
}

- (void)durationChanged:(BBCSMPDuration*)duration
{
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime
{
}

- (void)playerRateChanged:(float)newPlayerRate
{
}

#pragma mark BBCSMPPlayButtonSceneDelegate

- (void)playButtonSceneDidReceiveTap:(id<BBCSMPPlayButtonScene>)playButtonScene
{
    [_player play];
    [_userInteractionsTracer notifyObserversUsingSelector:@selector(playButtonTapped)];
}

#pragma mark BBCSMPPauseButtonSceneDelegate

- (void)pauseButtonSceneDidReceiveTap:(id<BBCSMPPauseButtonScene>)pauseButtonScene
{
    [_player pause];
    [_userInteractionsTracer notifyObserversUsingSelector:@selector(pauseButtonTapped)];
}

#pragma mark BBCSMPStopButtonSceneDelegate

- (void)stopButtonDidReceiveTap:(id<BBCSMPStopButtonScene>)stopButton
{
    [_player stop];
    [_userInteractionsTracer notifyObserversUsingSelector:@selector(stopButtonTapped)];
}

#pragma mark BBCSMPPreloadMetadataObserver

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata *)preloadMetadata
{
    [_playButtonScene setPlayButtonIcon:_avTypesToIcons[@(preloadMetadata.partialMetadata.avType)]];
}

#pragma mark BBCSMPUnpreparedStateListener

- (void)playerDidEnterUnpreparedState
{
    [_playButtonScene showPlayButton];
}

#pragma mark Private

- (BOOL)shouldPresentPlayButtonForCurrentState
{
    switch (_state) {
        case BBCSMPStateLoadingItem:
        case BBCSMPStateItemLoaded:
        case BBCSMPStatePreparingToPlay:
        case BBCSMPStatePlayerReady:
        case BBCSMPStatePaused:
            return YES;

        default:
            return NO;
    }
}

- (void)updatePlayActionButton
{
    if([self playerHasEnteredTerminalState]) {
        [_playButtonScene hidePlayButton];
        [_pauseButtonScene hidePauseButton];
        [_stopButtonScene hideStopButton];
    }
    else if ([self shouldPresentPlayButtonForCurrentState]) {
        [_playButtonScene showPlayButton];
        [_pauseButtonScene hidePauseButton];
        [_stopButtonScene hideStopButton];
    }
    else {
        [self updatePlayActionButtonForPlayingState];
    }
}

- (BOOL)playerHasEnteredTerminalState
{
    return _state == BBCSMPStateIdle || _state == BBCSMPStateEnded || _state == BBCSMPStateError;
}

- (void)updatePlayActionButtonForPlayingState
{
    [_playButtonScene hidePlayButton];

    if ([self isContentScrubbable]) {
        [_pauseButtonScene showPauseButton];
        [_stopButtonScene hideStopButton];
    }
    else {
        [_stopButtonScene showStopButton];
        [_pauseButtonScene hidePauseButton];
    }
}

- (BOOL)isContentScrubbable
{
    return !_live || (_liveScrubbable && _configuration.liveRewindEnabled);
}

#pragma mark BBCSMPTransportControlsViewSpaceDelegate

-(void)spaceRestricted {
    [_transportControlSpaceObserver spaceRestricted];
}

-(void)spaceAvailable {
    [_transportControlSpaceObserver spaceAvailable];
}

@end
