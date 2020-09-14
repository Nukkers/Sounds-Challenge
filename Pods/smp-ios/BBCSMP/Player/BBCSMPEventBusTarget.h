//
//  BBCSMPEventBusTarget.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPEventBusTarget : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak, nullable) id target;
@property (nonatomic, assign) SEL selector;

- (instancetype)initWithTarget:(id)target selector:(SEL)selector NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
