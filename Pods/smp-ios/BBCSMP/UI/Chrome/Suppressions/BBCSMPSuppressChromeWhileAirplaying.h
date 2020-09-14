//
//  BBCSMPSuppressChromeWhileAirplaying.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPChromeSupression;
@protocol BBCSMP;

@interface BBCSMPSuppressChromeWhileAirplaying : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                                   player:(id<BBCSMP>)player NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
