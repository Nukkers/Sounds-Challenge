//
//  BBCSMPUserInteractionsTracer.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPUserInteractionsTracer.h"

@interface BBCSMPUserInteractionsTracer ()

@property (nonatomic, copy) NSArray<id<BBCSMPUserInteractionObserver>> *userInteractionObservers;

@end

#pragma mark -

@implementation BBCSMPUserInteractionsTracer

#pragma mark Initialization

- (instancetype)initWithUserInteractionObservers:(NSArray<id<BBCSMPUserInteractionObserver>> *)userInteractionObservers
{
    self = [super init];
    if(self) {
        _userInteractionObservers = [userInteractionObservers copy];
    }
    
    return self;
}

#pragma mark Public

- (void)notifyObserversUsingSelector:(SEL)selector
{
    [_userInteractionObservers makeObjectsPerformSelector:selector];
}

- (void)notifyObserversUsingBlock:(void(^)(id<BBCSMPUserInteractionObserver>))block
{
    for(id<BBCSMPUserInteractionObserver> observer in _userInteractionObservers) {
        block(observer);
    }
}

@end
