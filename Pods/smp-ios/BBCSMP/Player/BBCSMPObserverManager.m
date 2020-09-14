//
//  BBCSMPObserverManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 28/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserverManager.h"
#import "BBCSMPTimeObserver.h"

@interface BBCSMPObserverManager ()

@property (nonatomic, strong) NSHashTable* observersTable;
@property (nonatomic, strong) NSHashTable* uiObserversTable;
@property (nonatomic, strong) NSHashTable* timeObserversTable;

@property (nonatomic, strong, readonly) NSArray<id<BBCSMPObserver> >* allObservers;
@property (nonatomic, strong, readonly) NSArray<id<BBCSMPObserver> >* uiObservers;

@end

@implementation BBCSMPObserverManager

- (instancetype)init
{
    if ((self = [super init])) {
        _observersTable = [NSHashTable weakObjectsHashTable];
        _uiObserversTable = [NSHashTable weakObjectsHashTable];
        _timeObserversTable = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)setRetainsObservers:(BOOL)retainsObservers
{
    if (_retainsObservers == retainsObservers)
        return;

    NSArray<id<BBCSMPObserver> >* tempObservers = [_observersTable allObjects];
    _retainsObservers = retainsObservers;
    if (_retainsObservers) {
        _observersTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPersonality];
    }
    else {
        _observersTable = [NSHashTable weakObjectsHashTable];
    }
    for (id<BBCSMPObserver> observer in tempObservers) {
        [_observersTable addObject:observer];
    }
}

- (NSArray<id<BBCSMPObserver> >*)allObservers
{
    return [_observersTable allObjects];
}

- (NSArray<id<BBCSMPObserver> >*)uiObservers
{
    return [_uiObserversTable allObjects];
}

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    NSAssert([observer conformsToProtocol:@protocol(BBCSMPObserver)], @"Observer does not conform to BBCSMPObserver protocol");
    [_observersTable addObject:observer];
    
    if([observer conformsToProtocol:@protocol(BBCSMPTimeObserver)]){
        [_timeObserversTable addObject:observer];
    }
    
    if ([observer respondsToSelector:@selector(observerType)] && [observer observerType] == BBCSMPObserverTypeUI) {
        [_uiObserversTable addObject:observer];
    }
}

- (void)removeObserver:(id<BBCSMPObserver>)observer
{
    [_observersTable removeObject:observer];
    [_timeObserversTable removeObject:observer];
    [_uiObserversTable removeObject:observer];
}

- (NSArray<id<BBCSMPObserver> >*)observersConformingToProtocol:(Protocol*)protocol
{
    NSMutableArray* observersConformingToProtocol = [NSMutableArray new];
    for (id obj in self.allObservers) {
        if ([obj conformsToProtocol:protocol]) {
            [observersConformingToProtocol addObject:obj];
        }
    }

    return observersConformingToProtocol;
}

- (void)notifyObserversForProtocol:(Protocol*)protocol withBlock:(void (^)(id observer))block
{
    [self notifyObservers:self.allObservers forProtocol:protocol withBlock:block];
}

- (void)notifyUIObserversForProtocol:(Protocol*)protocol withBlock:(void (^)(id observer))block
{
    [self notifyObservers:self.uiObservers forProtocol:protocol withBlock:block];
}

- (void)notifyObservers:(NSArray<id<BBCSMPObserver> >*)observers forProtocol:(Protocol*)protocol withBlock:(void (^)(id observer))block
{
    if(@protocol(BBCSMPTimeObserver) == protocol){
        for (id obj in observers) {
            if([_timeObserversTable containsObject:obj]){
                block(obj);
            }
        }
    }else{
        for (id obj in observers) {
            if ([obj conformsToProtocol:protocol]) {
                block(obj);
            }
        }
    }
}

@end
