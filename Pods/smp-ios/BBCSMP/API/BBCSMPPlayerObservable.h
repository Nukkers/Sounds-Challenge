//
//  BBCSMPPlayerObservable.h
//  BBCSMP
//
//  Created by Timothy James Condon on 17/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPObserver;
@protocol BBCSMPAVStatisticsConsumer;
@protocol BBCSMPPlaybackStateObserver;

@protocol BBCSMPPlayerObservable <NSObject>

- (void)addObserver:(id<BBCSMPObserver>)observer NS_SWIFT_NAME(add(observer:));
- (void)removeObserver:(id<BBCSMPObserver>)observer NS_SWIFT_NAME(remove(observer:));


- (void)addStateObserver:(id<BBCSMPPlaybackStateObserver>)observer NS_SWIFT_NAME(add(stateObserver:));
- (void)removeStateObserver:(id<BBCSMPPlaybackStateObserver>)observer NS_SWIFT_NAME(remove(stateObserver:));



@end

NS_ASSUME_NONNULL_END
