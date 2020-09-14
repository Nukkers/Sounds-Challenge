//
//  BBCSMPRegisteredDisplay.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPVideoSurface;

@interface BBCSMPRegisteredDisplay : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak, readonly) id<BBCSMPVideoSurface> videoSurface;

- (instancetype)initWithVideoSurface:(id<BBCSMPVideoSurface>)videoSurface NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
