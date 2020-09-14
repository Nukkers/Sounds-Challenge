//
//  BBCSMPObserverManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 28/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@interface BBCSMPObserverManager : NSObject

@property (nonatomic, assign) BOOL retainsObservers;

- (void)addObserver:(id<BBCSMPObserver>)observer NS_SWIFT_NAME(add(observer:));
- (void)removeObserver:(id<BBCSMPObserver>)observer NS_SWIFT_NAME(remove(observer:));

- (void)notifyObserversForProtocol:(Protocol*)protocol withBlock:(void (^)(id))block NS_SWIFT_NAME(notifyObservers(for:with:));
- (void)notifyUIObserversForProtocol:(Protocol*)protocol withBlock:(void (^)(id))block NS_SWIFT_NAME(notifyUIObservers(for:with:));

- (NSArray<id<BBCSMPObserver> >*)observersConformingToProtocol:(Protocol*)protocol NS_SWIFT_NAME(observers(conformingTo:));

@end
