//
//  BBCSMPVideoSurfaceController.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 15/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@class CALayer;
@class BBCSMPViewControllerEventsCoordinator;
@protocol BBCSMPVideoSurfaceManager;

@protocol BBCSMPVideoSurfaceControllerObserver <NSObject>
@required

- (void)videoSurfaceDidBecomeAvailable:(CALayer *)videoSurface;
- (void)videoSurfaceDidDetach;

@end

@interface BBCSMPVideoSurfaceController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithVideoSurfaceManager:(id<BBCSMPVideoSurfaceManager>)videoSurfaceManager
         viewControllerLifecycleCoordinator:(BBCSMPViewControllerEventsCoordinator *)viewControllerLifecycleCoordinator NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(id<BBCSMPVideoSurfaceControllerObserver>)observer;

@end

NS_ASSUME_NONNULL_END
