//
//  BBCSMPEventBus.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPEventBus.h"
#import "BBCSMPEventBusTarget.h"

typedef NSMutableArray<BBCSMPEventBusTarget *> BBCSMPMutableEventBusTargetsArray;

@implementation BBCSMPEventBus {
    NSMapTable<Class, BBCSMPMutableEventBusTargetsArray *> *_targets;
}

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if(self) {
        _targets = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory
                                         valueOptions:NSMapTableStrongMemory];
    }
    
    return self;
}

#pragma mark Public

- (NSUInteger)count
{
    NSUInteger count = 0;
    for (Class key in [_targets keyEnumerator]) {
        BBCSMPMutableEventBusTargetsArray *targetsForEvent = [_targets objectForKey:key];
        count += targetsForEvent.count;
    }
    
    return count;
}

- (void)addTarget:(id<NSObject>)target selector:(SEL)selector forEventType:(Class)eventType
{
    BBCSMPEventBusTarget *eventBusTarget = [[BBCSMPEventBusTarget alloc] initWithTarget:target selector:selector];
    BBCSMPMutableEventBusTargetsArray *targetsForEvent = [_targets objectForKey:eventType];
    if (!targetsForEvent) {
        targetsForEvent = [BBCSMPMutableEventBusTargetsArray array];
        [_targets setObject:targetsForEvent forKey:eventType];
    }
    
    [targetsForEvent addObject:eventBusTarget];
}

- (void)sendEvent:(id<NSObject>)event
{
    BBCSMPMutableEventBusTargetsArray *targetsForEvent = [_targets objectForKey:[event class]];
    BBCSMPMutableEventBusTargetsArray *targetsToRemove = [BBCSMPMutableEventBusTargetsArray array];
    for(BBCSMPEventBusTarget *target in [targetsForEvent copy]) {
        [self dispatchEvent:event toTarget:target appendingDeallocatedTargetsIntoArray:targetsToRemove];
    }
    
    [targetsForEvent removeObjectsInArray:targetsToRemove];
}

#pragma mark Private

- (void)dispatchEvent:(id<NSObject> _Nonnull)event toTarget:(BBCSMPEventBusTarget *)target appendingDeallocatedTargetsIntoArray:(BBCSMPMutableEventBusTargetsArray *)targetsToRemove {
    id receiver = target.target;
    SEL selector = target.selector;
    
    if (receiver) {
        IMP implementation = [receiver methodForSelector:selector];
        if (implementation) {
            void(*method)(id, SEL, id) = (void (*)(id, SEL, id))implementation;
            method(receiver, selector, event);
        }
    }
    else {
        [targetsToRemove addObject:target];
    }
}

@end
