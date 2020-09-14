//
//  BBCSMPUIScreenAdapterFactory.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDisplayCoordinatorProtocol.h"
#import "BBCSMPUIScreenAdapter.h"
#import "BBCSMPUIScreenAdapterFactory.h"
#import <UIKit/UIKit.h>

@interface BBCSMPUIScreenAdapterFactory ()

@property (nonatomic, strong) NSNotificationCenter* notificationCenter;
@property (nonatomic, strong) NSMapTable<UIScreen*, BBCSMPUIScreenAdapter*>* screenAdapters;
@property (nonatomic, strong) NSMutableArray<UIScreen*>* unhandledAvailableScreens;

@end

@implementation BBCSMPUIScreenAdapterFactory

@synthesize coordinator = _coordinator;

- (void)dealloc
{
    [_notificationCenter removeObserver:self];
}

- (instancetype)init
{
    return self = [self initWithNotificationCenter:[NSNotificationCenter defaultCenter] screens:[UIScreen screens]];
}

- (instancetype)initWithNotificationCenter:(NSNotificationCenter*)notificationCenter screens:(NSArray<UIScreen*>*)screens
{
    self = [super init];
    if (self) {
        _screenAdapters = [NSMapTable weakToStrongObjectsMapTable];
        _unhandledAvailableScreens = [NSMutableArray new];

        _notificationCenter = notificationCenter;
        [notificationCenter addObserver:self selector:@selector(screenDidBecomeAvailable:) name:UIScreenDidConnectNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(screenDidBecomeUnavailable:) name:UIScreenDidDisconnectNotification object:nil];

        for (UIScreen* screen in screens) {
            if (![screen isEqual:[UIScreen mainScreen]]) {
                [self registerScreen:screen];
            }
        }
    }

    return self;
}

- (void)setCoordinator:(id<BBCSMPDisplayCoordinatorProtocol>)coordinator
{
    _coordinator = coordinator;

    for (UIScreen* screen in _unhandledAvailableScreens) {
        [self attachAvailableScreen:screen];
    }

    [_unhandledAvailableScreens removeAllObjects];
}

- (void)screenDidBecomeAvailable:(NSNotification*)notification
{
    UIScreen* screen = notification.object;
    if (_coordinator) {
        [self attachAvailableScreen:screen];
    }
    else {
        [_unhandledAvailableScreens addObject:screen];
    }
}

- (void)screenDidBecomeUnavailable:(NSNotification*)notification
{
    UIScreen* screen = notification.object;
    BBCSMPUIScreenAdapter* screenAdapter = [_screenAdapters objectForKey:screen];
    [_coordinator detachVideoSurface:screenAdapter];
    [_screenAdapters removeObjectForKey:screen];
    [_unhandledAvailableScreens removeObject:screen];
}

- (void)registerScreen:(UIScreen*)screen
{
    if (_coordinator) {
        [self attachAvailableScreen:screen];
    }
    else {
        [_unhandledAvailableScreens addObject:screen];
    }
}

- (void)attachAvailableScreen:(UIScreen*)screen
{
    BBCSMPUIScreenAdapter* adapter = [_screenAdapters objectForKey:screen];
    if (!adapter) {
        adapter = [[BBCSMPUIScreenAdapter alloc] initWithScreen:screen];
        [_screenAdapters setObject:adapter forKey:screen];
    }

    [_coordinator attachVideoSurface:adapter];
}

@end
