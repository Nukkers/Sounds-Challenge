//
//  BBCSMPUIBuilder.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>
#import "BBCSMPAccessibilityAnnouncer.h"

NS_ASSUME_NONNULL_BEGIN

@class UIImage;
@class UIView;
@class UIViewController;
@class BBCSMPBrand;

@protocol BBCSMPPlayerViewFactory;
@protocol BBCSMPPlayerViewFullscreenPresenter;
@protocol BBCSMPPluginFactory;
@protocol BBCSMPUIConfiguration;
@protocol BBCSMPStatisticsConsumer;
@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPUserInteractionObserver;

@protocol BBCSMPUIBuilder <NSObject>
@required

- (instancetype)withFrame:(CGRect)frame;
- (instancetype)withEmbeddedConfiguration:(id<BBCSMPUIConfiguration>)embeddedConfiguration;
- (instancetype)withFullscreenConfiguration:(id<BBCSMPUIConfiguration>)fullscreenConfiguration;
- (instancetype)withPluginFactories:(NSArray<id<BBCSMPPluginFactory> >*)pluginFactories;
- (instancetype)withFullscreenPresenter:(nullable id<BBCSMPPlayerViewFullscreenPresenter>)fullscreenPresenter;
- (instancetype)withStatisticsConsumers:(NSSet<id<BBCSMPStatisticsConsumer> >*)statisticsConsumers;
- (instancetype)withBrand:(BBCSMPBrand*)brand;
- (instancetype)withUserInteractionObservers:(NSArray<id<BBCSMPUserInteractionObserver>> *)userInteractionObservers NS_SWIFT_NAME(with(userInteractionObservers:));
- (instancetype)withDefaultErrorImage:(UIImage *)defaultErrorImage NS_SWIFT_NAME(with(defaultErrorImage:));
- (instancetype)withClassicCloseIcon;
- (instancetype)withAccessibilityAnnouncer:(id<BBCSMPAccessibilityAnnouncer>)accessibilityAnnouncer;

- (UIView*)buildView;
- (UIViewController*)buildViewController;

@end

NS_ASSUME_NONNULL_END
