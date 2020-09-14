//
//  BBCSMPNotificationReceptionist.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPNotificationReceptionist.h"
#import "BBCSMPWorker.h"

@implementation BBCSMPNotificationReceptionist {
    NSNotificationCenter *_notificationCenter;
    __weak id _target;
    SEL _selector;
    id<BBCSMPWorker> _callbackWorker;
}

#pragma mark Deallocation

- (void)dealloc
{
    [_notificationCenter removeObserver:self];
}

#pragma mark Class Methods

+ (instancetype)receptionistWithNotificationName:(NSString*)name
                    postedFromNotificationCenter:(NSNotificationCenter*)notificationCenter
                                      fromObject:(id)object
                                  callbackWorker:(id<BBCSMPWorker>)worker
                                          target:(id)target
                                        selector:(SEL)selector
{
    return [[self alloc] initWithNotificationName:name
                     postedFromNotificationCenter:notificationCenter
                                       fromObject:object
                                   callbackWorker:worker
                                           target:target
                                         selector:selector];
}

#pragma mark Initialization

- (instancetype)initWithNotificationName:(NSString*)name
            postedFromNotificationCenter:(NSNotificationCenter*)notificationCenter
                              fromObject:(id)object
                          callbackWorker:(id<BBCSMPWorker>)worker
                                  target:(id)target
                                selector:(SEL)selector
{
    self = [super init];
    if (self) {
        _notificationCenter = notificationCenter;
        _target = target;
        _selector = selector;
        _callbackWorker = worker;

        [notificationCenter addObserver:self
                               selector:@selector(handleNotification:)
                                   name:name
                                 object:object];
    }

    return self;
}

#pragma mark Notification Handling

- (void)handleNotification:(NSNotification*)notification
{
    __weak typeof(self) weakSelf = self;
    [_callbackWorker performWork:^{
        [weakSelf notifyTargetWithNotification:notification];
    }];
}

- (void)notifyTargetWithNotification:(NSNotification *)notification
{
    id target = _target;
    if(target) {        
        IMP imp = [_target methodForSelector:_selector];
        void (*method)(id, SEL, NSNotification*) = (void*)imp;
        method(_target, _selector, notification);
    }
}

@end
