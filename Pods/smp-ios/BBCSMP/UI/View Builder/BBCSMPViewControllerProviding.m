//
//  BBCSMPViewControllerProviding.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 01/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPViewControllerProviding.h"
#import "BBCSMPPlayerViewFactory.h"
#import "BBCSMPPlayerPresenterFactory.h"
#import "BBCSMPPresentationContext.h"
#import "BBCSMPViewControllerProtocol.h"
#import "BBCSMPUIConfiguration.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPViewControllerProviding {
    BBCSMPViewContext *_viewContext;
    BBCSMPPresentationContext *_presentationContext;
    id<BBCSMPPlayerViewFactory> _playerViewFactory;
    id<BBCSMPPlayerPresenterFactory> _presenterFactory;
}

#pragma mark Initialization

- (instancetype)initWithViewContext:(BBCSMPViewContext *)viewContext
              viewControllerFactory:(id<BBCSMPPlayerViewFactory>)viewControllerFactory
                presentationContext:(BBCSMPPresentationContext *)presentationContext
                   presenterFactory:(id<BBCSMPPlayerPresenterFactory>)presenterFactory
{
    self = [super init];
    if(self) {
        _viewContext = viewContext;
        _presentationContext = presentationContext;
        _playerViewFactory = viewControllerFactory;
        _presenterFactory = presenterFactory;
    }
    
    return self;
}

#pragma mark Public

- (UIViewController *)createViewController
{
    UIViewController<BBCSMPViewControllerProtocol>* viewController = [_playerViewFactory createViewControllerWithContext:_viewContext];
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    viewController.supportAllOrientations = _presentationContext.configuration.allowPortrait;
    
    _presentationContext.view = (UIView<BBCSMPView> *)viewController.view;
    _presentationContext.statusBar = viewController;
    _presentationContext.homeIndicator = viewController;
    _presentationContext.fullscreenViewController = viewController;
    
    [_presenterFactory buildPresentersWithContext:_presentationContext];
    
    return viewController;
}

@end
