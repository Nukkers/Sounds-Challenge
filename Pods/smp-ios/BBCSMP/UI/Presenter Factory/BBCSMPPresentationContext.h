//
//  BBCSMPPresentationContext.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPPresentationMode.h"

NS_ASSUME_NONNULL_BEGIN

@class UIImage;
@class UIViewController;

@class BBCSMPFullscreenStateProviding;
@class BBCSMPAccessibilityIndex;
@class BBCSMPBrand;
@class BBCSMPPresentationControllers;
@class BBCSMPNavigationCoordinator;
@protocol BBCSMP;
@protocol BBCSMPStateObservable;
@protocol BBCSMPVideoSurfaceManager;
@protocol BBCSMPView;
@protocol BBCSMPPresenterCommands;
@protocol BBCSMPPluginFactory;
@protocol BBCSMPUIConfiguration;
@protocol BBCSMPStatusBar;
@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPAccessibilityAnnouncer;
@protocol BBCSMPUserInteractionObserver;
@protocol BBCSMPTimeFormatterProtocol;
@protocol BBCSMPViewControllerProtocol;
@protocol BBCSMPDeviceTraits;
@protocol BBCSMPAccessibilityStateProviding;
@protocol BBCSMPTimeIntervalFormatter;
@protocol BBCSMPHomeIndicatorScene;

@interface BBCSMPPresentationContext : NSObject

@property (nonatomic, strong) id<BBCSMP, BBCSMPStateObservable> player;
@property (nonatomic, weak) id<BBCSMPVideoSurfaceManager> videoSurfaceManager;
@property (nonatomic, weak) id<BBCSMPView> view;
@property (nonatomic, strong) BBCSMPBrand *brand;
@property (nonatomic, strong) BBCSMPNavigationCoordinator *navigationCoordinator;
@property (nonatomic, strong) BBCSMPAccessibilityIndex* accessibilityIndex;
@property (nonatomic, copy) NSSet<id<BBCSMPPluginFactory> >* pluginFactories;
@property (nonatomic, strong) id<BBCSMPUIConfiguration> configuration;
@property (nonatomic, weak) id<BBCSMPStatusBar> statusBar;
@property (nonatomic, weak) id<BBCSMPHomeIndicatorScene> homeIndicator;
@property (nonatomic, assign) BBCSMPPresentationMode presentationMode;
@property (nonatomic, strong) id<BBCSMPTimerFactoryProtocol> timerFactory;
@property (nonatomic, strong) BBCSMPFullscreenStateProviding* fullscreenStateProviding;
@property (nonatomic, strong) id<BBCSMPAccessibilityAnnouncer> accessibilityAnnouncer;
@property (nonatomic, strong) NSArray<id<BBCSMPUserInteractionObserver>>* userInteractionObservers;
@property (nonatomic, weak) UIViewController<BBCSMPViewControllerProtocol> *fullscreenViewController;
@property (nonatomic, strong) BBCSMPPresentationControllers *presentationControllers;
@property (nonatomic, strong) id<BBCSMPTimeFormatterProtocol> timeFormatter;
@property (nonatomic, strong) id<BBCSMPTimeFormatterProtocol> callToActionDurationFormatter;
@property (nonatomic, strong) id<BBCSMPDeviceTraits> deviceTraits;
@property (nonatomic, strong) id<BBCSMPAccessibilityStateProviding> accessibilityStateProviding;
@property (nonatomic, strong) id<BBCSMPTimeIntervalFormatter> scrubberPositionFormatter;
@property (nonatomic, strong, nullable) UIImage *placeholderErrorImage;

@end

NS_ASSUME_NONNULL_END
