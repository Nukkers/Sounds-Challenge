//
//  BBCSMPTimeBasedAutorecoveryRule+Internal.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 06/11/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTimeBasedAutorecoveryRule.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTimerFactoryProtocol;

@interface BBCSMPTimeBasedAutorecoveryRule ()

- (instancetype)initWithTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
       permittedAutorecoveryInterval:(NSTimeInterval)autorecoveryInterval NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
