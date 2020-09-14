//
//  BBCSMPPlayerViewFullscreenPresenter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;

@protocol BBCSMPPlayerViewFullscreenPresenter <NSObject>
@required

- (void)enterFullscreenByPresentingViewController:(UIViewController*)viewController completion:(void (^)(void))completion;
- (void)leaveFullscreenByDismissingViewController:(UIViewController*)viewController completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
