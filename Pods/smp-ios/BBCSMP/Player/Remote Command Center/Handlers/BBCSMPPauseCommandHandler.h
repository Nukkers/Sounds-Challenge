//
//  BBCSMPPauseCommandHandler.h
//  BBCSMP
//
//  Created by Richard Gilpin on 24/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPCommandCenterControlHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@class BBCSMPRemotePauseCommandRule;

@interface BBCSMPPauseCommandHandler : NSObject <BBCSMPCommandCenterControlHandler>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP>)player
                     pauseRule:(BBCSMPRemotePauseCommandRule*)pauseRule
                   nextHandler:(nullable id<BBCSMPCommandCenterControlHandler>)commandCenterControlHandler;

@end

NS_ASSUME_NONNULL_END
