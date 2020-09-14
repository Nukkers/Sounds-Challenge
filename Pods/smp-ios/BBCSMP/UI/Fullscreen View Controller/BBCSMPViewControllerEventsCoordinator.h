//
//  BBCSMPViewControllerEventsCoordinator.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPViewControllerProtocol;

@protocol BBCSMPViewControllerLifecycleEventObserver <NSObject>
@required

- (void)viewControllerWillAppear;
- (void)viewControllerDidAppear;
- (void)viewControllerWillDisappear;
- (void)viewControllerDidDisappear;

@end

@protocol BBCSMPViewControllerAccessibilityEscapeHandler <NSObject>
@required

- (void)performEscape;

@end

@interface BBCSMPViewControllerEventsCoordinator : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak, nullable) id<BBCSMPViewControllerAccessibilityEscapeHandler> accessibilityEscapeGestureHandler;

- (instancetype)initWithViewController:(id<BBCSMPViewControllerProtocol>)viewController NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(id<BBCSMPViewControllerLifecycleEventObserver>)observer;

@end

NS_ASSUME_NONNULL_END
