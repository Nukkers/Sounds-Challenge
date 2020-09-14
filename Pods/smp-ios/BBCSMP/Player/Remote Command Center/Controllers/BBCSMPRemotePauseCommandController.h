//
//  BBCSMPRemotePauseCommandController.h
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
@class BBCSMPRemoteStopCommandRule;
@class BBCSMPRemotePauseCommandRule;

@interface BBCSMPRemotePauseCommandController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
           remoteCommandCenter:(id<BBCSMPRemoteCommandCenter>)remoteCommandCenter
                      stopRule:(BBCSMPRemoteStopCommandRule*)stopRule
                     pauseRule:(BBCSMPRemotePauseCommandRule*)pauseRule NS_DESIGNATED_INITIALIZER;

- (void)unregisterCommand;

@end

NS_ASSUME_NONNULL_END
