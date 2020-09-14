//
//  BBCSMPState.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BBCSMPStateEnumeration) {
    BBCSMPStateIdle = 0,
    BBCSMPStateLoadingItem,
    BBCSMPStateItemLoaded,
    BBCSMPStatePreparingToPlay,
    BBCSMPStatePlayerReady,
    BBCSMPStatePlaying, //used by decoder, be warned
    BBCSMPStateBuffering,
    BBCSMPStatePaused,
    BBCSMPStateEnded,
    BBCSMPStateError,
    BBCSMPStateStopping
};

extern NSString * NSStringFromBBCSMPStateEnumeration(BBCSMPStateEnumeration);

NS_SWIFT_NAME(SMPPublicState)
@interface BBCSMPState : NSObject

@property (nonatomic, assign, readonly) BBCSMPStateEnumeration state;

+ (instancetype)idleState;
+ (instancetype)loadingItemState;
+ (instancetype)itemLoadedState;
+ (instancetype)preparingToPlayState;
+ (instancetype)playerReadyState;
+ (instancetype)playingState;
+ (instancetype)bufferingState;
+ (instancetype)pausedState;
+ (instancetype)endedState;
+ (instancetype)errorState;
+ (instancetype)stoppingState;

@end

NS_ASSUME_NONNULL_END
