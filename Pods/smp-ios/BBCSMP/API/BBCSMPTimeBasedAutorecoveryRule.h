//
//  BBCSMPTimeBasedAutorecoveryRule.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 03/11/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPAutorecoveryRule.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTimerFactoryProtocol;

NS_SWIFT_NAME(TimeBasedAutorecoveryRule)
@interface BBCSMPTimeBasedAutorecoveryRule : NSObject <BBCSMPAutorecoveryRule>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPermittedAutorecoveryInterval:(NSTimeInterval)autorecoveryInterval;

@end

NS_ASSUME_NONNULL_END
