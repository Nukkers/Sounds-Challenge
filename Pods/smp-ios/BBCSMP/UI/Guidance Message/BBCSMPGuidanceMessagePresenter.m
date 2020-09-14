//
//  BBCSMPGuidanceMessagePresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 14/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPGuidanceMessagePresenter.h"
#import "BBCSMPGuidanceMessageScene.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPState.h"

@interface BBCSMPGuidanceMessagePresenter () <BBCSMPPreloadMetadataObserver, BBCSMPStateObserver>
@end

#pragma mark -

@implementation BBCSMPGuidanceMessagePresenter {
    __weak id<BBCSMPGuidanceMessageScene> _guidanceMessageScene;
    NSString* _guidanceMessage;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _guidanceMessageScene = context.view.scenes.guidanceMessageScene;

        [context.player addObserver:self];
    }

    return self;
}

#pragma mark BBCSMPPreloadMetadataObserver

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    _guidanceMessage = preloadMetadata.guidanceMessage;
    if (_guidanceMessage) {
        [_guidanceMessageScene show];
        [_guidanceMessageScene presentGuidanceMessage:_guidanceMessage];
        
        NSString *accessibilityLabel = [NSString stringWithFormat:@"Guidance, %@", _guidanceMessage];
        [_guidanceMessageScene setGuidanceMessageAccessibilityLabel:accessibilityLabel];
    }
    else {
        [_guidanceMessageScene hide];
    }
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState*)state
{
    switch (state.state) {
    case BBCSMPStateIdle:
    case BBCSMPStateEnded:
        if (_guidanceMessage) {
            [_guidanceMessageScene show];
        }
        break;

    default:
        [_guidanceMessageScene hide];
        break;
    }
}

@end
