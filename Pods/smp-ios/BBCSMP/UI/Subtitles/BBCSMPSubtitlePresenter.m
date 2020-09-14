//
//  BBCSMPSubtitlePresenter.m
//  BBCSMP
//
//  Created by Daniel Ellis on 21/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPSubtitlePresenter.h"
#import "BBCSMPErrorObserver.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPSubtitleScene.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPVideoSurfaceController.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPVideoRectObserver.h"

@interface BBCSMPSubtitlePresenter () <BBCSMPErrorObserver,
                                       BBCSMPVideoRectObserver,
                                       BBCSMPSubtitleObserver,
                                       BBCSMPVideoSurfaceControllerObserver>
@end

#pragma mark -

@implementation BBCSMPSubtitlePresenter {
    __weak id<BBCSMPView> _view;
    __weak id<BBCSMPSubtitleScene> _scene;
    BOOL _subtitlesActive;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _view = context.view;
        _scene = _view.scenes.subtitlesScene;

        [context.player addObserver:self];
        [context.presentationControllers.videoSurfaceController addObserver:self];
    }

    return self;
}


#pragma mark BBCSMPErrorObserver

- (void)errorOccurred:(BBCSMPError*)error
{
    [_scene hideSubtitles];
}

#pragma mark BBCSMPVideoRectObserver

- (void)player:(id<BBCSMP>)player videoRectDidChange:(CGRect)videoRect
{
    _view.videoRect = videoRect;
}

#pragma mark BBCSMPSubtitleObserver

- (void)subtitleAvailabilityChanged:(NSNumber *)available {}

- (void)subtitleActivationChanged:(NSNumber *)active
{
    _subtitlesActive = active.boolValue;
    if(_subtitlesActive) {
        [_scene showSubtitles];
    }
    else {
        [_scene hideSubtitles];
    }
}

- (void)styleDictionaryUpdated:(NSDictionary *)styleDictionary baseStyleKey:(NSString *)baseStyleKey
{
    [_scene styleDictionaryUpdated:styleDictionary baseStyleKey:baseStyleKey];
}

- (void)subtitlesUpdated:(NSArray<BBCSMPSubtitle *> *)subtitles
{
    [_scene subtitlesUpdated:subtitles];
}

#pragma mark BBCSMPVideoSurfaceControllerObserver

- (void)videoSurfaceDidBecomeAvailable:(__unused CALayer *)videoSurface
{
    if(_subtitlesActive) {
        [_scene showSubtitles];
    }
}

- (void)videoSurfaceDidDetach
{
    [_scene hideSubtitles];
}

@end
