//
//  BBCSMPPlayerViewFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIView;
@class UIViewController;
@class BBCSMPViewContext;
@protocol BBCSMPView;
@protocol BBCSMPViewControllerProtocol;

@protocol BBCSMPPlayerViewFactory <NSObject>
@required

- (UIView<BBCSMPView>*)createViewWithContext:(BBCSMPViewContext*)context;
- (UIViewController<BBCSMPViewControllerProtocol>*)createViewControllerWithContext:(BBCSMPViewContext*)context;

@end

NS_ASSUME_NONNULL_END
