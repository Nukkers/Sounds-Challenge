//
//  BBCSMPVideoSurfacePresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 17/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPVideoSurfacePresenter.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPVideoSurfaceScene.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPVideoSurfaceController.h"
#import <QuartzCore/QuartzCore.h>

@interface BBCSMPVideoSurfacePresenter () <BBCSMPVideoSurfaceControllerObserver>
@end

#pragma mark -

@implementation BBCSMPVideoSurfacePresenter {
    __weak id<BBCSMPVideoSurfaceScene> _scene;
    __weak CALayer *_attachedVideoSurface;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _scene = context.view.scenes.videoSurfaceScene;
        [context.presentationControllers.videoSurfaceController addObserver:self];
    }
    
    return self;
}


#pragma mark BBCSMPVideoSurfaceControllerObserver

- (void)videoSurfaceDidBecomeAvailable:(CALayer *)videoSurface
{
    _attachedVideoSurface = videoSurface;
    [_scene showVideoLayer:videoSurface];
    [_scene appear];
}

- (void)videoSurfaceDidDetach
{
    [_scene disappear];
    [_attachedVideoSurface removeFromSuperlayer];
}

@end
