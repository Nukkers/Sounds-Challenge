//
//  BBCSMPAVBufferingEvent.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 17/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAVBufferingEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly, getter=isBuffering) BOOL buffering;

+ (instancetype)eventWithBuffering:(BOOL)buffering;
- (instancetype)initWithBuffering:(BOOL)buffering NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
