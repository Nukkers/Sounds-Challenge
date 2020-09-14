//
//  BBCSMPNavigationCoordinator.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;
@class BBCSMPViewControllerProviding;
@protocol BBCSMP;
@protocol BBCSMPPlayerViewFullscreenPresenter;

@protocol BBCSMPNavigationCoordinatorObserver <NSObject>
@required

- (void)didLeaveFullscreen;
- (void)didEnterFullscreen;

@end

@interface BBCSMPNavigationCoordinator : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak, nullable) UIViewController *presentedViewController;

- (instancetype)initWithPlayer:(id<BBCSMP>)player;
- (instancetype)initWithPlayer:(id<BBCSMP>)player
           fullscreenPresenter:(nullable id<BBCSMPPlayerViewFullscreenPresenter>)fullscreenPresenter
       viewControllerProviding:(nullable BBCSMPViewControllerProviding *)fullscreenViewControllerProviding NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(id<BBCSMPNavigationCoordinatorObserver>)observer;
- (void)leaveFullscreen;
- (void)enterFullscreen;
- (void)teardown;

@end

NS_ASSUME_NONNULL_END
