//
//  BBCSMPPresentationControllers.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPresentationControllers.h"
#import "BBCSMPPresentationContext.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPScrubberScene.h"
#import "BBCSMPScrubberController.h"
#import "BBCSMPUserInteractionsTracer.h"
#import "BBCSMPChromeVisibilityCoordinator.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPVideoSurfaceController.h"
#import "BBCSMPViewControllerEventsCoordinator.h"

@implementation BBCSMPPresentationControllers

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext*)context
{
    self = [super init];
    if(self) {
        _scrubberController = [BBCSMPScrubberController new];
        context.view.scenes.scrubberScene.scrubberDelegate = _scrubberController;
        
        _viewControllerLifecycleCoordinator = [[BBCSMPViewControllerEventsCoordinator alloc] initWithViewController:context.fullscreenViewController];
        
        _userInteractionsTracer = [[BBCSMPUserInteractionsTracer alloc] initWithUserInteractionObservers:context.userInteractionObservers];
        
        _chromeVisibilityCoordinator = [[BBCSMPChromeVisibilityCoordinator alloc] initWithPlayer:context.player permittedInactivityPeriod:context.configuration.inactivityPeriod scenes:context.view.scenes scrubberController:_scrubberController timerFactory:context.timerFactory viewControllerLifecycleCoordinator:_viewControllerLifecycleCoordinator accessibilityStateProviding:context.accessibilityStateProviding statusBar:context.statusBar];

        _videoSurfaceController = [[BBCSMPVideoSurfaceController alloc] initWithVideoSurfaceManager:context.videoSurfaceManager viewControllerLifecycleCoordinator:_viewControllerLifecycleCoordinator];
    }
    
    return self;
}

@end
