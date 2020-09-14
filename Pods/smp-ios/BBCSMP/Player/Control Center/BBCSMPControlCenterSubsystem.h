//
//  BBCSMPControlCenterSubsystem.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@protocol MPNowPlayingInfoCenterProtocol;
@protocol BBCSMPRemoteCommandCenter;
@protocol BBCSMPBackgroundStateProvider;

@interface BBCSMPControlCenterSubsystem : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
          nowPlayingInfoCenter:(id<MPNowPlayingInfoCenterProtocol>)nowPlayingInfoCenter
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
      backgroundStateProviding:(id<BBCSMPBackgroundStateProvider>)backgroundStateProviding NS_DESIGNATED_INITIALIZER;

- (void)teardown;

@end

NS_ASSUME_NONNULL_END
