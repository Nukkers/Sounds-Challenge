//
// Created by Charlotte Hoare on 07/10/2016.
// Copyright (c) 2016 BBC. All rights reserved.
//

#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPPlayCTAButtonPresenter.h"
#import "BBCSMPPlayCTAButtonScene.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPTimeFormatterProtocol.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPAVType.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPState.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPPlayCTAButtonPresenter () <BBCSMPPlayCTAButtonSceneDelegate,
                                            BBCSMPPreloadMetadataObserver,
                                            BBCSMPPlaybackStateObserver>
@end

#pragma mark -

@implementation BBCSMPPlayCTAButtonPresenter {
    __weak id<BBCSMP> _player;
    __weak id<BBCSMPPlayCTAButtonScene> _playCTAButtonScene;
    id<BBCSMPUIConfiguration> _configuration;
    id<BBCSMPTimeFormatterProtocol> _durationFormatter;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _player = context.player;
        _playCTAButtonScene = context.view.scenes.playCTAButtonScene;
        _configuration = context.configuration;
        _playCTAButtonScene.delegate = self;
        _durationFormatter = context.callToActionDurationFormatter;
        
        [_player addObserver:self];
        [_player addStateObserver:self];
    }

    return self;
}

- (NSString*)avTypeStringWithType:(BBCSMPAVType)avType
{
    switch (avType) {
        case BBCSMPAVTypeVideo:
            return @"Video";
        default:
            return @"Audio";
    }
}

#pragma mark BBCSMPPlayCTAButtonSceneDelegate

- (void)callToActionSceneDidReceiveTap:(id<BBCSMPPlayCTAButtonScene>)playCTAScene
{
    [_player play];
}

#pragma mark BBCSMPPreloadMetadataObserver

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata*)preloadMetadata {
    if(_configuration.standInPlayButtonStyle == BBCSMPStandInPlayButtonStyleIconAndDuration && preloadMetadata.duration != nil)
    {
        [_playCTAButtonScene showDurationWithDuration:preloadMetadata.duration];
        
        NSString *formattedDuration = [_durationFormatter stringFromDuration:preloadMetadata.duration];
        [_playCTAButtonScene showDuration];
        [_playCTAButtonScene setFormattedDurationString:formattedDuration];
    }
    else {
        [_playCTAButtonScene hideDuration];
    }
    
    [_playCTAButtonScene setAvType:preloadMetadata.partialMetadata.avType];
    [_playCTAButtonScene setPlayCallToActionAccessibilityLabel:[NSString stringWithFormat:@"Play %@", [self avTypeStringWithType:preloadMetadata.partialMetadata.avType]]];
    [_playCTAButtonScene setPlayCallToActionAccessibilityHint:[NSString stringWithFormat:@"Double Tap To Play %@", [self avTypeStringWithType:preloadMetadata.partialMetadata.avType]]];
}

#pragma mark BBCSMPPlaybackStateObserver

- (void)state:(id<SMPPlaybackState> _Nonnull)state {
    if ([(id)state isKindOfClass:[SMPPlaybackStateEnded class]] ||
        [(id)state isKindOfClass:[SMPPlaybackStateUnprepared class]]) {
        [_playCTAButtonScene appear];
    }
    else {
        [_playCTAButtonScene disappear];
    }
}

@end
