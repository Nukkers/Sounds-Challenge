//
//  BBCSMPAirplayManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@protocol BBCSMPAirplayObserver;
@protocol BBCSMPAirplayAvailabilityProvider;
@protocol BBCSMPAudioSession;
@protocol BBCSMPExternalPlaybackAdapter;

@interface BBCSMPAirplayManager : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) BOOL airplayAvailable;
@property (nonatomic, assign, readonly) BOOL airplayActive;
@property (nonatomic, strong) id<BBCSMPExternalPlaybackAdapter> externalPlaybackAdapter;

- (instancetype)initWithAirplayAvailabilityProvider:(id<BBCSMPAirplayAvailabilityProvider>)airplayAvailabilityProvider NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(id<BBCSMPAirplayObserver>)observer NS_SWIFT_NAME(add(observer:));
- (void)removeObserver:(id<BBCSMPAirplayObserver>)observer NS_SWIFT_NAME(remove(observer:));

@end
