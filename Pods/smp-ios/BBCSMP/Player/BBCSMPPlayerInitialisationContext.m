//
//  BBCSMPPlayerInitialisationContext.m
//  BBCSMP
//
//  Created by Al Priest on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPPlayerInitialisationContext.h"
#import "BBCSMPSize.h"
#import "BBCSMPState.h"
#import "BBCSMPTimerFactory.h"

@interface BBCSMPPlayerInitialisationContext ()

@property (nonatomic, strong) NSMutableSet<id<BBCSMPObserver> >* observers;

@end

@implementation BBCSMPPlayerInitialisationContext

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observers = [NSMutableSet set];
        _timerFactory = [[BBCSMPTimerFactory alloc] init];
    }

    return self;
}

#pragma mark Public

- (NSArray<id<BBCSMPObserver> >*)playerObservers
{
    return [_observers allObjects];
}

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [_observers addObject:observer];
}

@end
