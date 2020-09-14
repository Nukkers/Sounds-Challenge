//
//  BBCSMPDefaultPlayerViewFactory.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefaultPlayerViewFactory.h"
#import "BBCSMPPlayerView.h"
#import "BBCSMPFullscreenViewController.h"
#import "BBCSMPViewContext.h"
#import "BBCSMPMeasurementPolicies.h"
#import "BBCSMPSystemSensitiveSafeAreaGuideProvidingFactory.h"

@implementation BBCSMPDefaultPlayerViewFactory {
    BBCSMPMeasurementPolicies *_measurementPolicies;
    id<BBCSMPSafeAreaGuideProvidingFactory> _safeAreaGuideProvidingFactory;
}

#pragma mark Initialization

- (instancetype)init
{
    BBCSMPSystemSensitiveSafeAreaGuideProvidingFactory *safeAreaGuideProvidingFactory = [[BBCSMPSystemSensitiveSafeAreaGuideProvidingFactory alloc] init];
    return self = [self initWithMeasurementPolicies:[[BBCSMPMeasurementPolicies alloc] init]
                      safeAreaGuideProvidingFactory:safeAreaGuideProvidingFactory];
}

- (instancetype)initWithMeasurementPolicies:(BBCSMPMeasurementPolicies *)measurementPolicies
              safeAreaGuideProvidingFactory:(id<BBCSMPSafeAreaGuideProvidingFactory>)safeAreaGuideProvidingFactory
{
    self = [super init];
    if(self) {
        _measurementPolicies = measurementPolicies;
        _safeAreaGuideProvidingFactory = safeAreaGuideProvidingFactory;
    }
    
    return self;
}

#pragma mark BBCSMPPlayerViewFactory

- (UIView<BBCSMPView>*)createViewWithContext:(BBCSMPViewContext*)context
{
    return [self createViewWithContext:context usingConfiguration:context.embeddedConfiguration];
}

- (UIViewController<BBCSMPViewControllerProtocol>*)createViewControllerWithContext:(BBCSMPViewContext*)context
{
    UIView* view = [self createViewWithContext:context usingConfiguration:context.fullscreenConfiguration];
    BBCSMPFullscreenViewController *viewController = [[BBCSMPFullscreenViewController alloc] init];
    viewController.view = view;
    
    return viewController;
}


#pragma mark Private

- (UIView<BBCSMPView>*)createViewWithContext:(BBCSMPViewContext *)context usingConfiguration:(id<BBCSMPUIConfiguration>)configuration
{
    BBCSMPPlayerView* view = [[BBCSMPPlayerView alloc] initWithFrame:context.frame
                                                              player:context.player
                                                       configuration:configuration
                                                 measurementPolicies:_measurementPolicies
                                       safeAreaGuideProvidingFactory:_safeAreaGuideProvidingFactory];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.brand = context.brand;
    view.fullscreenUIConfiguration = context.fullscreenConfiguration;
    
    return view;
}

@end
