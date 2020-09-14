//
//  BBCSMPRemoteStopCommandRule.h
//  BBCSMP
//
//  Created by Jenna Brown on 16/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@class BBCSMPRulePlayerStateProvider;

@interface BBCSMPRemoteStopCommandRule : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithRuleStateProvider:(BBCSMPRulePlayerStateProvider *)ruleStateProvider NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL shouldStop;

@end

NS_ASSUME_NONNULL_END
