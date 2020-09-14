//
//  BBCSMPFullscreenViewController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPFullscreenViewController.h"
#import "BBCSMPViewControllerDelegate.h"

@implementation BBCSMPFullscreenViewController {
    BOOL _shouldHideStatusBar;
    BOOL _shouldPreferHomeIndicatorAutohiding;
}

#pragma mark Lifecycle Callbacks

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_delegate viewWillAppear];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_delegate viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_delegate viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_delegate viewDidDisappear];
}

#pragma mark Overrides

- (BOOL)prefersStatusBarHidden
{
    return _shouldHideStatusBar;
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    return _shouldPreferHomeIndicatorAutohiding;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIInterfaceOrientationMask orientationMask = UIInterfaceOrientationMaskLandscape;
    if(_supportAllOrientations) {
        orientationMask = UIInterfaceOrientationMaskAll;
    }
    
    return orientationMask;
}

- (BOOL)accessibilityPerformEscape
{
    return [_delegate viewDidReceiveAccessibilityPerformEscapeGesture];
}

#pragma mark BBCSMPViewControllerProtocol

@synthesize delegate = _delegate;
@synthesize supportAllOrientations = _supportAllOrientations;

- (void)showStatusBar
{
    _shouldHideStatusBar = NO;
#if !TARGET_OS_TV
    [self setNeedsStatusBarAppearanceUpdate];
#endif
}

- (void)hideStatusBar
{
    _shouldHideStatusBar = YES;
#if !TARGET_OS_TV
    [self setNeedsStatusBarAppearanceUpdate];
#endif
}

- (void)disableHomeIndicatorAutohiding
{
    _shouldPreferHomeIndicatorAutohiding = NO;
}

- (void)enableHomeIndicatorAutohiding
{
    _shouldPreferHomeIndicatorAutohiding = YES;
}

- (void)updateHomeIndicatorAutoHiddenState
{
#if !TARGET_OS_TV
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
    [self setNeedsUpdateOfHomeIndicatorAutoHidden];
#pragma clang diagnostic pop
#endif
}

@end
