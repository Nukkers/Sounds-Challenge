//
//  BBCSMPRulePlayerStateProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPState.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@protocol BBCSMPItem;
@protocol BBCSMPBackgroundStateProvider;

@interface BBCSMPRulePlayerStateProvider : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly, nullable) id<BBCSMPItem> playerItem;
@property (nonatomic, assign, readonly) BOOL isInBackground;
@property (nonatomic, assign, readonly) BOOL airplayActive;
@property (nonatomic, assign, readonly) BOOL isInPictureInPicture;
@property (nonatomic, assign, readonly) BBCSMPStateEnumeration state;
@property (nonatomic, assign, readonly) BOOL isLiveRewindable;

@property (nonatomic, readonly) BOOL isPlayingSimulcast;
@property (nonatomic, readonly) BOOL isPlayerPlaying;

- (instancetype)initWithPlayer:(id<BBCSMP>)player
      backgroundStateProviding:(id<BBCSMPBackgroundStateProvider>)backgroundStateProviding NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
