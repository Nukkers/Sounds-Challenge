//
//  BBCSMPPresentationControllers.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPPresentationContext;
@class BBCSMPScrubberController;
@class BBCSMPUserInteractionsTracer;
@class BBCSMPChromeVisibilityCoordinator;
@class BBCSMPVideoSurfaceController;
@class BBCSMPViewControllerEventsCoordinator;

@interface BBCSMPPresentationControllers : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) BBCSMPScrubberController *scrubberController;
@property (nonatomic, strong, readonly) BBCSMPUserInteractionsTracer *userInteractionsTracer;
@property (nonatomic, strong, readonly) BBCSMPChromeVisibilityCoordinator *chromeVisibilityCoordinator;
@property (nonatomic, strong, readonly) BBCSMPVideoSurfaceController *videoSurfaceController;
@property (nonatomic, strong, readonly) BBCSMPViewControllerEventsCoordinator *viewControllerLifecycleCoordinator;

- (instancetype)initWithContext:(BBCSMPPresentationContext*)context NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
