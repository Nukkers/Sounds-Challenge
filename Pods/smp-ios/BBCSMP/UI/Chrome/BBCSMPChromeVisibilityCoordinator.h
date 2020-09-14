//
//  BBCSMPChromeVisibilityCoordinator.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPChromeSupression.h"
#import "BBCSMPChromeVisibility.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPScrubberController;
@class BBCSMPViewControllerEventsCoordinator;
@protocol BBCSMP;
@protocol BBCSMPPlayerScenes;
@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPAccessibilityStateProviding;
@protocol BBCSMPStatusBar;

@class BBCSMPChromeVisibilityCoordinator;

@protocol BBCSMPChromeVisibilityCoordinatorDelegate <NSObject>
@required

- (void)chromeVisibilityCoordinatorDidResolveChromeShouldAppear:(BBCSMPChromeVisibilityCoordinator*)chromeSuppressor;
- (void)chromeVisibilityCoordinatorDidResolveChromeShouldDisappear:(BBCSMPChromeVisibilityCoordinator*)chromeSuppressor;

@end

@interface BBCSMPChromeVisibilityCoordinator : NSObject <BBCSMPChromeSupression, BBCSMPChromeVisibility>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak, nullable) id<BBCSMPChromeVisibilityCoordinatorDelegate> delegate;

- (instancetype)initWithPlayer:(id<BBCSMP>)player
     permittedInactivityPeriod:(NSTimeInterval)inactivityPeriod
                        scenes:(id<BBCSMPPlayerScenes>)scenes
            scrubberController:(BBCSMPScrubberController *)scrubberController
                  timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
viewControllerLifecycleCoordinator:(BBCSMPViewControllerEventsCoordinator*)viewControllerLifecycleCoordinator
   accessibilityStateProviding:(id<BBCSMPAccessibilityStateProviding>)accessibilityStateProviding
                     statusBar:(id<BBCSMPStatusBar>)statusBar NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
