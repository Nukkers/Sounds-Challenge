//
//  BBCSMPPlayerViewBuilder.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAutomaticallyDismissingFullscreenPresenter.h"
#import "BBCSMPBrand.h"
#import "BBCSMPDefaultAccessibilityAnnouncer.h"
#import "BBCSMPMutableViewContext.h"
#import "BBCSMPPlayerPluginEnviroment.h"
#import "BBCSMPPlayerPresenterFactory.h"
#import "BBCSMPPlayerViewBuilder.h"
#import "BBCSMPPlayerViewFactory.h"
#import "BBCSMPPresentationContext.h"
#import "BBCSMPTimerFactory.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPUIEmbeddedDefaultConfiguration.h"
#import "BBCSMPUIFullscreenDefaultConfiguration.h"
#import "BBCSMPVideoSurfaceManager.h"
#import "BBCSMPView.h"
#import "BBCSMPTimeFormatter.h"
#import "BBCSMPNavigationCoordinator.h"
#import "BBCSMPViewControllerProtocol.h"
#import "BBCSMPUIDeviceTraits.h"
#import "BBCSMPViewControllerProviding.h"
#import "BBCSMPUIAccessibilityStateProviding.h"
#import "BBCSMPTimeIntervalFormatter.h"
#import "BBCSMPSystemTimeIntervalFormatter.h"
#import "BBCSMPClosePlayerIcon.h"
#import "BBCSMPBrandingIcons.h"
#import "BBCSMPStateObservable.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPPlayerViewBuilder {
    id<BBCSMP, BBCSMPStateObservable> _player;
    id<BBCSMPVideoSurfaceManager> _videoSurfaceManager;
    id<BBCSMPPlayerViewFactory> _playerViewFactory;
    id<BBCSMPPlayerPresenterFactory> _presenterFactory;
    CGRect _frame;
    BBCSMPBrand* _brand;
    id<BBCSMPTimerFactoryProtocol> _timerFactory;
    id<BBCSMPUIConfiguration> _embeddedConfiguration;
    id<BBCSMPUIConfiguration> _fullscreenConfiguration;
    NSSet<id<BBCSMPPluginFactory> >* _pluginFactories;
    id<BBCSMPPlayerViewFullscreenPresenter> _fullscreenPresenter;
    id<BBCSMPAccessibilityAnnouncer> _accessibilityAnnouncer;
    NSSet<id<BBCSMPStatisticsConsumer> >* _statisticsConsumers;
    BBCSMPFullscreenStateProviding* _fullscreenStateProviding;
    NSArray<id<BBCSMPUserInteractionObserver>> *_userInteractionObservers;
    id<BBCSMPTimeFormatterProtocol> _timeFormatter;
    id<BBCSMPTimeFormatterProtocol> _callToActionTimeFormatter;
    BBCSMPNavigationCoordinator *_navigationCoordinator;
    id<BBCSMPDeviceTraits> _deviceTraits;
    BBCSMPViewControllerProviding *_viewControllerProviding;
    UIViewController *_builtViewController;
    id<BBCSMPAccessibilityStateProviding> _accessibilityStateProviding;
    id<BBCSMPTimeIntervalFormatter> _scrubberPositionFormatter;
    UIImage *_defaultErrorImage;
    BOOL _useClassicCloseIcon;
}

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<BBCSMP, BBCSMPStateObservable>)player
           videoSurfaceManager:(id<BBCSMPVideoSurfaceManager>)videoSurfaceManager
              presenterFactory:(id<BBCSMPPlayerPresenterFactory>)presenterFactory
{
    self = [super init];
    if (self) {
        _player = player;
        _videoSurfaceManager = videoSurfaceManager;
        _presenterFactory = presenterFactory;
        _frame = CGRectZero;
        _brand = [BBCSMPBrand new];
        _embeddedConfiguration = [BBCSMPUIEmbeddedDefaultConfiguration new];
        _fullscreenConfiguration = [BBCSMPUIFullscreenDefaultConfiguration new];
        _pluginFactories = [NSSet set];
        _statisticsConsumers = [NSSet set];
        _timerFactory = [BBCSMPTimerFactory new];
        _accessibilityAnnouncer = [BBCSMPDefaultAccessibilityAnnouncer new];
        _timeFormatter = [BBCSMPTimeFormatter new];
        _callToActionTimeFormatter = _timeFormatter;
        _deviceTraits = [BBCSMPUIDeviceTraits new];
        _accessibilityStateProviding = [BBCSMPUIAccessibilityStateProviding new];
        _scrubberPositionFormatter = [[BBCSMPSystemTimeIntervalFormatter alloc] init];
    }

    return self;
}

#pragma mark BBCSMPViewBuilder

- (instancetype)withViewFactory:(id<BBCSMPPlayerViewFactory>)viewFactory
{
    _playerViewFactory = viewFactory;
    return self;
}

- (instancetype)withFrame:(CGRect)frame
{
    _frame = frame;
    return self;
}

- (instancetype)withEmbeddedConfiguration:(id<BBCSMPUIConfiguration>)embeddedConfiguration
{
    _embeddedConfiguration = embeddedConfiguration;
    return self;
}

- (instancetype)withFullscreenConfiguration:(id<BBCSMPUIConfiguration>)fullscreenConfiguration
{
    _fullscreenConfiguration = fullscreenConfiguration;
    return self;
}

- (instancetype)withPluginFactories:(NSArray<id<BBCSMPPluginFactory> >*)pluginFactories
{
    _pluginFactories = [NSSet setWithArray:pluginFactories];
    return self;
}

- (instancetype)withFullscreenPresenter:(id<BBCSMPPlayerViewFullscreenPresenter>)fullscreenPresenter
{
    _fullscreenPresenter = fullscreenPresenter;
    return self;
}

- (instancetype)withStatisticsConsumers:(NSSet<id<BBCSMPStatisticsConsumer> >*)statisticsConsumers
{
    _statisticsConsumers = statisticsConsumers;
    return self;
}

- (instancetype)withBrand:(BBCSMPBrand*)brand
{
    _brand = brand;
    return self;
}

- (instancetype)withTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
{
    _timerFactory = timerFactory;
    return self;
}

- (instancetype)withAccessibilityAnnouncer:(id<BBCSMPAccessibilityAnnouncer>)accessibilityAnnouncer
{
    _accessibilityAnnouncer = accessibilityAnnouncer;
    return self;
}

- (instancetype)withUserInteractionObservers:(NSArray<id<BBCSMPUserInteractionObserver>> *)userInteractionObservers
{
    _userInteractionObservers = [userInteractionObservers copy];
    return self;
}

- (instancetype)withTimeFormatter:(id<BBCSMPTimeFormatterProtocol>)timeFormatter
{
    _timeFormatter = timeFormatter;
    return self;
}

- (instancetype)withCallToActionTimeFormatter:(id<BBCSMPTimeFormatterProtocol>)callToActionTimeFormatter
{
    _callToActionTimeFormatter = callToActionTimeFormatter;
    return self;
}

- (instancetype)withDeviceTraits:(id<BBCSMPDeviceTraits>)deviceTraits
{
    _deviceTraits = deviceTraits;
    return self;
}

- (instancetype)withAccessibilityStateProviding:(id<BBCSMPAccessibilityStateProviding>)accessibilityStateProviding
{
    _accessibilityStateProviding = accessibilityStateProviding;
    return self;
}

- (instancetype)withDefaultErrorImage:(UIImage *)defaultErrorImage
{
    _defaultErrorImage = defaultErrorImage;
    return self;
}

- (instancetype)withClassicCloseIcon
{
    _useClassicCloseIcon = YES;
    return self;
}

- (instancetype)withScrubberPositionFormatter:(id<BBCSMPTimeIntervalFormatter>)scrubberPositionFormatter
{
    _scrubberPositionFormatter = scrubberPositionFormatter;
    return self;
}

- (UIView*)buildView
{
    BBCSMPMutableViewContext* context = [self prepareMutableViewContext];
    UIView<BBCSMPView>* view = [_playerViewFactory createViewWithContext:context];
    if(_fullscreenPresenter) {
        [self prepareViewControllerProvidingForPresentationMode:BBCSMPPresentationModeFullscreenFromEmbedded];
    }
    else {
        _navigationCoordinator = [[BBCSMPNavigationCoordinator alloc] initWithPlayer:_player];
    }
    
    BBCSMPPresentationContext* presentationContext = [self preparePresentationContextForPresentationMode:BBCSMPPresentationModeEmbedded];
    presentationContext.view = view;

    [_presenterFactory buildPresentersWithContext:presentationContext];

    return view;
}

- (UIViewController *)buildViewController
{
    [self prepareViewControllerProvidingForPresentationMode:BBCSMPPresentationModeFullscreen];
    return _builtViewController;
}

#pragma mark Private

- (BBCSMPPresentationContext *)preparePresentationContextForPresentationMode:(BBCSMPPresentationMode)presentationMode
{
    if(_useClassicCloseIcon) {
        _brand.icons.closePlayerIcon = [[BBCSMPClosePlayerIcon alloc] init];
    }
    
    BBCSMPPresentationContext* presentationContext = [BBCSMPPresentationContext new];
    presentationContext.presentationMode = presentationMode;
    presentationContext.player = _player;
    presentationContext.brand = _brand;
    presentationContext.navigationCoordinator = _navigationCoordinator;
    presentationContext.pluginFactories = _pluginFactories;
    presentationContext.configuration = presentationMode == BBCSMPPresentationModeEmbedded ? _embeddedConfiguration : _fullscreenConfiguration;
    presentationContext.timerFactory = _timerFactory;
    presentationContext.fullscreenStateProviding = _fullscreenStateProviding;
    presentationContext.accessibilityIndex = _brand.accessibilityIndex;
    presentationContext.accessibilityAnnouncer = _accessibilityAnnouncer;
    presentationContext.userInteractionObservers = _userInteractionObservers;
    presentationContext.timeFormatter = _timeFormatter;
    presentationContext.videoSurfaceManager = _videoSurfaceManager;
    presentationContext.deviceTraits = _deviceTraits;
    presentationContext.accessibilityStateProviding = _accessibilityStateProviding;
    presentationContext.placeholderErrorImage = _defaultErrorImage;
    presentationContext.callToActionDurationFormatter = _callToActionTimeFormatter;
    presentationContext.scrubberPositionFormatter = _scrubberPositionFormatter;
    
    return presentationContext;
}

- (BBCSMPMutableViewContext*)prepareMutableViewContext
{
    BBCSMPMutableViewContext* context = [BBCSMPMutableViewContext new];
    context.player = _player;
    context.frame = _frame;
    context.brand = _brand;
    context.embeddedConfiguration = _embeddedConfiguration;
    context.fullscreenConfiguration = _fullscreenConfiguration;
    context.pluginFactories = _pluginFactories;
    context.statisticsConsumers = _statisticsConsumers;

    return context;
}

- (void)prepareViewControllerProvidingForPresentationMode:(BBCSMPPresentationMode)presentationMode
{
    if(!_fullscreenPresenter) {
        _fullscreenPresenter = [BBCSMPAutomaticallyDismissingFullscreenPresenter new];
    }
    
    BBCSMPMutableViewContext* context = [self prepareMutableViewContext];
    BBCSMPPresentationContext* presentationContext = [self preparePresentationContextForPresentationMode:presentationMode];
    _viewControllerProviding = [[BBCSMPViewControllerProviding alloc] initWithViewContext:context
                                                                    viewControllerFactory:_playerViewFactory
                                                                      presentationContext:presentationContext
                                                                         presenterFactory:_presenterFactory];
    
    _navigationCoordinator = [[BBCSMPNavigationCoordinator alloc] initWithPlayer:_player
                                                             fullscreenPresenter:_fullscreenPresenter
                                                         viewControllerProviding:_viewControllerProviding];
    presentationContext.navigationCoordinator = _navigationCoordinator;
    
    if(presentationMode == BBCSMPPresentationModeFullscreen) {
        _builtViewController = [_viewControllerProviding createViewController];
        _navigationCoordinator.presentedViewController = _builtViewController;
    }
}

@end
