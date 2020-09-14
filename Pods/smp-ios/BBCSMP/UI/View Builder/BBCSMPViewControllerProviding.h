//
//  BBCSMPViewControllerProviding.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 01/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;
@class BBCSMPViewContext;
@class BBCSMPPresentationContext;
@protocol BBCSMPPlayerViewFactory;
@protocol BBCSMPPlayerPresenterFactory;

@interface BBCSMPViewControllerProviding : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithViewContext:(BBCSMPViewContext *)viewContext
              viewControllerFactory:(id<BBCSMPPlayerViewFactory>)viewControllerFactory
                presentationContext:(BBCSMPPresentationContext *)presentationContext
                   presenterFactory:(id<BBCSMPPlayerPresenterFactory>)presenterFactory NS_DESIGNATED_INITIALIZER;

- (UIViewController *)createViewController;

@end

NS_ASSUME_NONNULL_END
