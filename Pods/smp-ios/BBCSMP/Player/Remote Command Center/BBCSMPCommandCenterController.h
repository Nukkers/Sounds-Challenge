//
//  BBCSMPCommandCenterController.h
//  BBCSMP
//
//  Created by Richard Gilpin on 08/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPRemoteCommandCenter;
@protocol BBCSMP;
@protocol BBCSMPBackgroundStateProvider;

@interface BBCSMPCommandCenterController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
      backgroundStateProviding:(id<BBCSMPBackgroundStateProvider>)backgroundStateProviding NS_DESIGNATED_INITIALIZER;

- (void)unregisterFromRemoteCommandCenter;

@end

NS_ASSUME_NONNULL_END
