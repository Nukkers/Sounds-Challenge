//
//  BBCSMPContentPlaceholderPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPItem.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPContentPlaceholderPresenter.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPContentPlaceholderScene.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPAirplayObserver.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPDeviceTraits.h"
#import "BBCSMPState.h"
#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemObserver.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPContentPlaceholderPresenter () <BBCSMPAirplayObserver,
                                                 BBCSMPContentPlaceholderSceneDelegate,
                                                 BBCSMPPreloadMetadataObserver,
                                                 BBCSMPPlaybackStateObserver,
                                                 BBCSMPItemObserver>
@end

#pragma mark -

@implementation BBCSMPContentPlaceholderPresenter {
    __weak id<BBCSMPContentPlaceholderScene> _scene;
    id<BBCSMPDeviceTraits> _deviceTraits;
    UIImage *_fetchFailedImage;
    BOOL _airplayActive;
    BBCSMPStateEnumeration _state;
    id<SMPPlaybackState> _playbackState;
    id<BBCSMPArtworkFetcher> _artworkFetcher;
    BOOL _isAudio;
    BBCSMPItemPreloadMetadata *_metadata;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _scene = context.view.scenes.contentPlaceholderScene;
        _scene.delegate = self;
        _deviceTraits = context.deviceTraits;
        _fetchFailedImage = context.placeholderErrorImage;
        
        [context.player addObserver:self];
        [context.player addStateObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPAirplayObserver

- (void)airplayAvailabilityChanged:(NSNumber *)available {}

- (void)airplayActivationChanged:(NSNumber *)active
{
    _airplayActive = active.boolValue;
    [self updatePlaceholderVisibility];
}

#pragma mark BBCSMPContentPlaceholderSceneDelegate

- (void)contentPlaceholderSceneSizeDidChange:(__unused id<BBCSMPContentPlaceholderScene>)contentPlaceholderScene
{
    [self updateArtwork];
}

#pragma mark BBCSMPPreloadMetadataObserver

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata *)preloadMetadata
{
    _artworkFetcher = preloadMetadata.artworkFetcher;
    _metadata = preloadMetadata;
    
    [self updateArtwork];
}

#pragma mark BBCSMPPlaybackStateObserver

- (void)state:(id<SMPPlaybackState> _Nonnull)state {
    _playbackState = state;
    [self updatePlaceholderVisibility];
}


#pragma mark Private

- (void)updateArtwork
{
    if(CGSizeEqualToSize(CGSizeZero, _scene.placeholderSize)) {
        return;
    }
    
    id<BBCSMPContentPlaceholderScene> scene = _scene;
    UIImage *backupImage = _fetchFailedImage;
    [_artworkFetcher fetchArtworkImageAtSize:scene.placeholderSize
                                       scale:_deviceTraits.scale
                                     success:^(UIImage *artworkImage) {
                                         [scene showPlaceholderImage:artworkImage];
                                     } failure:^(__unused NSError * _Nonnull artworkError) {
                                         [scene showPlaceholderImage:backupImage];
                                     }];
}

- (void)updatePlaceholderVisibility
{
    if(_airplayActive || [self shouldShowPlaceholderForCurrentState] || _isAudio) {
        [_scene appear];
    }
    else {
        [_scene disappear];
    }
}

- (BOOL)shouldShowPlaceholderForCurrentState
{
    return [(id)_playbackState isKindOfClass:[SMPPlaybackStateUnprepared class]] ||
           [(id)_playbackState isKindOfClass:[SMPPlaybackStateFailed class]] ||
           [(id)_playbackState isKindOfClass:[SMPPlaybackStateEnded class]];
}

- (void)itemUpdated:(id<BBCSMPItem>)playerItem {
     _isAudio = (playerItem && playerItem.metadata.avType == BBCSMPAVTypeAudio);
}

@end
