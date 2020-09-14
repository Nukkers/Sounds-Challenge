//
//  BBCSMPRemotePlayCommandRule.h
//  BBCSMP
//
//  Created by Ryan Johnstone on 11/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPRulePlayerStateProvider;

@interface BBCSMPRemotePlayCommandRule : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithRuleStateProvider:(BBCSMPRulePlayerStateProvider *)ruleStateProvider NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL shouldPlay;

@end

NS_ASSUME_NONNULL_END
