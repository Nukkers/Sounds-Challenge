//
//  BBCSMPAccessibilityExitFullscreen.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityExitFullscreen.h"
#import "BBCSMPNavigationCoordinator.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPViewControllerEventsCoordinator.h"

@interface BBCSMPAccessibilityExitFullscreen () <BBCSMPViewControllerAccessibilityEscapeHandler>
@end

#pragma mark -

@implementation BBCSMPAccessibilityExitFullscreen {
    BBCSMPNavigationCoordinator *_navigationCoordinator;
}

#pragma mark BBCSMPPresenter

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _navigationCoordinator = context.navigationCoordinator;
        context.presentationControllers.viewControllerLifecycleCoordinator.accessibilityEscapeGestureHandler = self;
    }
    
    return self;
}

#pragma mark BBCSMPViewControllerAccessibilityEscapeHandler

- (void)performEscape
{
    [_navigationCoordinator leaveFullscreen];
}

@end
