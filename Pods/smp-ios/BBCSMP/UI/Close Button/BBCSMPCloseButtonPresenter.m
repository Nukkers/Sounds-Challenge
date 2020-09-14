//
//  BBCSMPCloseButtonPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPCloseButtonPresenter.h"
#import "BBCSMPCloseButtonScene.h"
#import "BBCSMPView.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPNavigationCoordinator.h"
#import "BBCSMPBrand.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPIcon.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPChromeVisibility.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPChromeVisibilityCoordinator.h"

@interface BBCSMPCloseButtonPresenter () <BBCSMPCloseButtonSceneDelegate, BBCSMPChromeVisibilityObserver>
@end

#pragma mark -

@implementation BBCSMPCloseButtonPresenter {
    __weak id<BBCSMPCloseButtonScene> _closeButtonScene;
    BBCSMPNavigationCoordinator *_navigationCoordinator;
    BBCSMPPresentationMode _presentationMode;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if(self) {
        _closeButtonScene = context.view.scenes.closeButtonScene;
        _closeButtonScene.closeButtonDelegate = self;
        _navigationCoordinator = context.navigationCoordinator;
        _presentationMode = context.presentationMode;
        [context.presentationControllers.chromeVisibilityCoordinator addVisibilityObserver:self];
        
        BBCSMPBrand *brand = context.brand;
        BBCSMPAccessibilityIndex *accessibilityIndex = brand.accessibilityIndex;
        id<BBCSMPIcon> closePlayerIcon = brand.icons.closePlayerIcon;
        closePlayerIcon.colour = brand.foregroundColor;
        
        [_closeButtonScene setCloseButtonIcon:closePlayerIcon];
        [_closeButtonScene setCloseButtonAccessibilityLabel:[accessibilityIndex labelForAccessibilityElement:BBCSMPAccessibilityElementDismissPlayerButton]];
        [_closeButtonScene setCloseButtonAccessibilityHint:[accessibilityIndex hintForAccessibilityElement:BBCSMPAccessibilityElementDismissPlayerButton]];
        
        if (_presentationMode == BBCSMPPresentationModeFullscreen) {
            [_closeButtonScene show];
        }
        else {
            [_closeButtonScene hide];
        }
    }
    
    return self;
}

#pragma mark BBCSMPCloseButtonSceneDelegate

- (void)closeButtonSceneDidTapClose:(id<BBCSMPCloseButtonScene>)closeButtonScene
{
    [_navigationCoordinator leaveFullscreen];
}

#pragma mark BBCSMPChromeVisibilityObserver

- (void)chromeDidBecomeVisible
{
    if (_presentationMode == BBCSMPPresentationModeFullscreen) {
        [_closeButtonScene show];
    }
}

- (void)chromeDidBecomeHidden
{
    [_closeButtonScene hide];
}

@end
