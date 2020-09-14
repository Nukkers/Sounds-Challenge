//
//  BBCSMPAutomaticallyDismissingFullscreenPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAutomaticallyDismissingFullscreenPresenter.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPAutomaticallyDismissingFullscreenPresenter

#pragma mark BBCSMPPlayerViewFullscreenPresenter

- (void)enterFullscreenByPresentingViewController:(UIViewController*)viewController completion:(void (^)(void))completion
{
}

- (void)leaveFullscreenByDismissingViewController:(UIViewController*)viewController completion:(void (^)(void))completion
{
    [viewController dismissViewControllerAnimated:YES completion:completion];
}

@end
