//
//  BBCSMPRemotePauseCommandRule.h
//  BBCSMP
//
//  Created by Richard Gilpin on 17/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@class BBCSMPRulePlayerStateProvider;

@interface BBCSMPRemotePauseCommandRule : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithRuleStateProvider:(BBCSMPRulePlayerStateProvider *)ruleStateProvider NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL shouldPause;

@end

NS_ASSUME_NONNULL_END
