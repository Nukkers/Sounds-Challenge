//
//  BBCSMPPlayerPluginEnviroment.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 26/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromeSupression.h"
#import "BBCSMPPlayerPluginEnviroment.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPView.h"
#import "BBCSMPNavigationCoordinator.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPPlayerPluginEnviroment {
    __weak id<BBCSMP> _player;
    __weak id<BBCSMPView> _view;
    __weak id<BBCSMPChromeSupression> _chromeSuppression;
    __weak BBCSMPNavigationCoordinator* _navigationCoordinator;
    __weak UIViewController* _playerViewController;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                          view:(id<BBCSMPView>)view
             chromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
         navigationCoordinator:(BBCSMPNavigationCoordinator *)navigationCoordinator
          playerViewController:(UIViewController*)playerViewController
{
    self = [super init];
    if (self) {
        _player = player;
        _view = view;
        _chromeSuppression = chromeSuppression;
        _navigationCoordinator = navigationCoordinator;
        _playerViewController = playerViewController;
    }

    return self;
}

#pragma mark BBCSMPPluginEnvironment

- (id<BBCSMPControllable>)playerControl
{
    return _player;
}

- (nonnull id<BBCSMPPlayerObservable>)observablePlayer {
    return _player;
}

- (id<BBCSMPPlayerState>)playerState
{
    return _player;
}

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [_player addObserver:observer];
}

- (void)removeObserver:(id<BBCSMPObserver>)observer
{
    [_player removeObserver:observer];
}

- (void)addButton:(UIView*)button inPosition:(BBCSMPButtonPosition)position
{
    [_view addButton:button inPosition:position];
}

- (void)removeButton:(UIView*)button
{
    [_view removeButton:button];
}

- (void)addOverlayView:(UIView*)overlayView inPosition:(BBCSMPOverlayPosition)position
{
    [_view addOverlayView:overlayView inPosition:position];
}

- (void)removeOverlayView:(UIView*)overlayView
{
    [_view removeOverlayView:overlayView];
}

- (void)suppressControlAutohideForReason:(NSString*)reason
{
    [_chromeSuppression suppressControlAutohideForReason:reason];
}

- (void)stopSuppressingControlAutohideForReason:(NSString*)reason
{
    [_chromeSuppression stopSuppressingControlAutohideForReason:reason];
}

- (void)leaveFullscreen
{
    [_navigationCoordinator leaveFullscreen];
}

- (void)presentPluginViewController:(UIViewController *)viewControllerToPresent
{
    [_playerViewController presentViewController:viewControllerToPresent animated:YES completion:nil];
}



@end
