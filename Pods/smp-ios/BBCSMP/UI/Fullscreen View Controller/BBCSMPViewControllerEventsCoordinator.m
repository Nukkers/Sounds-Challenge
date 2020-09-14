//
//  BBCSMPViewControllerEventsCoordinator.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPViewControllerEventsCoordinator.h"
#import "BBCSMPViewControllerProtocol.h"
#import "BBCSMPViewControllerDelegate.h"

@interface BBCSMPViewControllerEventsCoordinator () <BBCSMPViewControllerDelegate>
@end

#pragma mark -

@implementation BBCSMPViewControllerEventsCoordinator {
    NSMutableSet<id<BBCSMPViewControllerLifecycleEventObserver>> *_observers;
}

#pragma mark Initialization

- (instancetype)initWithViewController:(id<BBCSMPViewControllerProtocol>)viewController
{
    self = [super init];
    if(self) {
        _observers = [NSMutableSet set];
        viewController.delegate = self;
    }
    
    return self;
}

#pragma mark Public

- (void)addObserver:(id<BBCSMPViewControllerLifecycleEventObserver>)observer
{
    [_observers addObject:observer];
}

#pragma mark BBCSMPViewControllerDelegate

- (void)viewWillAppear
{
    [_observers makeObjectsPerformSelector:@selector(viewControllerWillAppear)];
}

- (void)viewDidAppear
{
    [_observers makeObjectsPerformSelector:@selector(viewControllerDidAppear)];
}

- (void)viewWillDisappear
{
    [_observers makeObjectsPerformSelector:@selector(viewControllerWillDisappear)];
}

- (void)viewDidDisappear
{
    [_observers makeObjectsPerformSelector:@selector(viewControllerDidDisappear)];
}

- (BOOL)viewDidReceiveAccessibilityPerformEscapeGesture
{
    [_accessibilityEscapeGestureHandler performEscape];
    return YES;
}

@end
