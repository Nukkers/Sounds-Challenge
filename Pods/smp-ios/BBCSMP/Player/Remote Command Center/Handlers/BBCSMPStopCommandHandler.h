//
//  BBCSMPStopCommandHandler.h
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPCommandCenterControlHandler.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@class BBCSMPRemoteStopCommandRule;

@interface BBCSMPStopCommandHandler : NSObject <BBCSMPCommandCenterControlHandler>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                      stopRule:(BBCSMPRemoteStopCommandRule*)stopRule
                   nextHandler:(nullable id<BBCSMPCommandCenterControlHandler>)commandCenterControlHandler;

@end

NS_ASSUME_NONNULL_END
