//
//  BBCSMPPlayCommandHandler.h
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPCommandCenterControlHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@class BBCSMPRemotePlayCommandRule;

@interface BBCSMPPlayCommandHandler : NSObject <BBCSMPCommandCenterControlHandler>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                      playRule:(BBCSMPRemotePlayCommandRule*)playRule
                   nextHandler:(nullable id<BBCSMPCommandCenterControlHandler>)commandCenterControlHandler;

@end

NS_ASSUME_NONNULL_END
