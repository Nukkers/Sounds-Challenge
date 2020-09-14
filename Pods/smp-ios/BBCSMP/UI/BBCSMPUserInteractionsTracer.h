//
//  BBCSMPUserInteractionsTracer.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPUserInteractionObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPUserInteractionsTracer : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithUserInteractionObservers:(NSArray<id<BBCSMPUserInteractionObserver>> *)userInteractionObservers NS_DESIGNATED_INITIALIZER;

- (void)notifyObserversUsingSelector:(SEL)selector;
- (void)notifyObserversUsingBlock:(void(^)(id<BBCSMPUserInteractionObserver>))block;

@end

NS_ASSUME_NONNULL_END
