//
//  BBCSMPSystemTimeIntervalFormatter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPTimeIntervalFormatter.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPSystemTimeIntervalFormatter : NSObject <BBCSMPTimeIntervalFormatter>

- (instancetype)initWithLocale:(NSLocale *)locale NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
