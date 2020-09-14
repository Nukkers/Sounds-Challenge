//
//  BBCSMPRemotePlayCommandController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@protocol BBCSMPRemoteCommandCenter;
@protocol BBCSMPBackgroundStateProvider;
@class BBCSMPRemotePlayCommandRule;

@interface BBCSMPRemotePlayCommandController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
                      playRule:(BBCSMPRemotePlayCommandRule*)playRule NS_DESIGNATED_INITIALIZER;

- (void)unregisterCommand;

@end

NS_ASSUME_NONNULL_END
