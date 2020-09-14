//
//  BBCSMPActivityViewPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPActivityScene.h"
#import "BBCSMPActivityViewPresenter.h"
#import "BBCSMPChromeVisibility.h"
#import "BBCSMPBrand.h"
#import "BBCSMPChromeVisibilityCoordinator.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"

@interface BBCSMPActivityViewPresenter () <BBCSMPChromeVisibilityObserver>
@end

#pragma mark -

@implementation BBCSMPActivityViewPresenter {
    __weak id<BBCSMPActivityScene> _activityScene;
    BBCSMPAccessibilityIndex* _accessibilityIndex;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _activityScene = context.view.scenes.activityScene;
        _accessibilityIndex = context.brand.accessibilityIndex;
        [_activityScene setActivitySceneAccessibilityLabel:[_accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementHidePlaybackControls]];
        [_activityScene setActivitySceneAccessibilityHint:[_accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementHidePlaybackControls]];

        [context.presentationControllers.chromeVisibilityCoordinator addVisibilityObserver:self];
    }

    return self;
}

#pragma mark BBCSMPChromeVisibilityObserver

- (void)chromeDidBecomeVisible
{
    [_activityScene setActivitySceneAccessibilityHint:[_accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementHidePlaybackControls]];
}

- (void)chromeDidBecomeHidden
{
    [_activityScene setActivitySceneAccessibilityHint:[_accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementShowPlaybackControls]];
}

@end
