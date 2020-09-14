//
//  BBCSMPPlayerViewPresenterFactory.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityAnnouncerPresenter.h"
#import "BBCSMPChromeVisibilityCoordinator.h"
#import "BBCSMPPlayerPluginEnviroment.h"
#import "BBCSMPPlayerViewPresenterFactory.h"
#import "BBCSMPPlugin.h"
#import "BBCSMPPluginFactory.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPKeepAlivePresentationContext.h"
#import "BBCSMPView.h"

#import "BBCSMPLiveIndicatorPresenter.h"
#import "BBCSMPVolumePresenter.h"
#import "BBCSMPFullscreenButtonPresenter.h"
#import "BBCSMPCloseButtonPresenter.h"
#import "BBCSMPErrorMessagePresenter.h"
#import "BBCSMPTitleSubtitlePresenter.h"
#import "BBCSMPTransportControlsPresenter.h"
#import "BBCSMPScrubberPresenter.h"
#import "BBCSMPChromePresenter.h"
#import "BBCSMPActivityViewPresenter.h"
#import "BBCSMPGuidanceMessagePresenter.h"
#import "BBCSMPAccessibilityAnnouncerPresenter.h"
#import "BBCSMPPlayCTAButtonPresenter.h"
#import "BBCSMPExitFullscreenWhenEnded.h"
#import "BBCSMPBufferingIndicatorPresenter.h"
#import "BBCSMPPictureInPictureButtonPresenter.h"
#import "BBCSMPVolumeStatisticsTracer.h"
#import "BBCSMPSubtitlesButtonPresenter.h"
#import "BBCSMPTimeLabelPresenter.h"
#import "BBCSMPTitlePresenter.h"
#import "BBCSMPSubtitlePresenter.h"
#import "BBCSMPVideoSurfacePresenter.h"
#import "BBCSMPAutoplayWhenViewWillAppear.h"
#import "BBCSMPContentPlaceholderPresenter.h"
#import "BBCSMPAirplayButtonPresenter.h"
#import "BBCSMPAccessibilityExitFullscreen.h"

@implementation BBCSMPPlayerViewPresenterFactory



#pragma mark Presenter Building

- (void)buildPresentersWithContext:(BBCSMPPresentationContext *)context
{
    BBCSMPPresentationControllers *controllers = [[BBCSMPPresentationControllers alloc] initWithContext:context];
    context.presentationControllers = controllers;

    NSMutableArray *presenters = [[NSMutableArray alloc] init];
    [presenters addObject:[[BBCSMPLiveIndicatorPresenter alloc] initWithContext:context]];
    BBCSMPVolumePresenter *volumePresenter = [[BBCSMPVolumePresenter alloc] initWithContext:context];
    [presenters addObject:volumePresenter];
    [presenters addObject:[[BBCSMPFullscreenButtonPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPErrorMessagePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPCloseButtonPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPTitlePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPTitleSubtitlePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPTransportControlsPresenter alloc] initWithContext:context transportControlSpaceObserver:volumePresenter]];
    [presenters addObject:[[BBCSMPScrubberPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPChromePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPActivityViewPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPGuidanceMessagePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPAccessibilityAnnouncerPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPPlayCTAButtonPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPExitFullscreenWhenEnded alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPBufferingIndicatorPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPPictureInPictureButtonPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPVolumeStatisticsTracer alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPSubtitlePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPTimeLabelPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPSubtitlesButtonPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPVideoSurfacePresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPAutoplayWhenViewWillAppear alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPContentPlaceholderPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPAirplayButtonPresenter alloc] initWithContext:context]];
    [presenters addObject:[[BBCSMPAccessibilityExitFullscreen alloc] initWithContext:context]];

    BBCSMPPlayerPluginEnviroment* pluginEnviroment = [[BBCSMPPlayerPluginEnviroment alloc] initWithPlayer:context.player view:context.view chromeSuppression:controllers.chromeVisibilityCoordinator navigationCoordinator:context.navigationCoordinator playerViewController:context.fullscreenViewController];
    NSSet<id<BBCSMPPluginFactory>> *pluginFactories = context.pluginFactories;
    NSMutableArray* plugins = [NSMutableArray arrayWithCapacity:pluginFactories.count];
    for (id<BBCSMPPluginFactory> pluginFactory in pluginFactories) {
        id<BBCSMPPlugin> plugin = [pluginFactory createPluginWithEnvironment:pluginEnviroment];
        [plugins addObject:plugin];
    }
    
    BBCSMPKeepAlivePresentationContext *keepAliveContext = [[BBCSMPKeepAlivePresentationContext alloc] initWithPresentationContext:context presenters:presenters plugins:plugins];
    context.view.context = keepAliveContext;
}


@end
