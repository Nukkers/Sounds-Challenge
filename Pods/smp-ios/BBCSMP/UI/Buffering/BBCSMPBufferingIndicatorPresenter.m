//
//  BBCSMPBufferingIndicatorPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPBufferingIndicatorPresenter.h"
#import "BBCSMPBufferingIndicatorScene.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPState.h"

@interface BBCSMPBufferingIndicatorPresenter () <BBCSMPStateObserver>
@end

#pragma mark -

@implementation BBCSMPBufferingIndicatorPresenter {
    __weak id<BBCSMPBufferingIndicatorScene> _bufferingIndicatorScene;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _bufferingIndicatorScene = context.view.scenes.bufferingIndicatorScene;
        [context.player addObserver:self];
    }
    
    return self;
}

#pragma mark BBCSMPPlaybackStateObserver

- (void)stateChanged:(BBCSMPState *)state
{
    switch (state.state) {
        case BBCSMPStateBuffering:
        case BBCSMPStateLoadingItem:
        case BBCSMPStatePreparingToPlay:
            [_bufferingIndicatorScene appear];
            break;
            
        default:
            [_bufferingIndicatorScene disappear];
            break;
    }
}

@end
