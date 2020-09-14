//
//  BBCSMPAudioManager.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAudioSession;
@protocol BBCSMPAudioManagerObserver;

@interface BBCSMPAudioManager : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithAudioSession:(id<BBCSMPAudioSession>)audioSession NS_DESIGNATED_INITIALIZER;
- (void)addObserver:(id<BBCSMPAudioManagerObserver>)observer NS_SWIFT_NAME(add(observer:));
- (void)removeObserver:(id<BBCSMPAudioManagerObserver>)observer NS_SWIFT_NAME(remove(observer:));

@end

NS_ASSUME_NONNULL_END
