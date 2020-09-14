//
//  BBCSMPEventBus.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPEventBus : NSObject

@property (readonly) NSUInteger count;

- (void)addTarget:(id<NSObject>)target selector:(SEL)selector forEventType:(Class)eventType;
- (void)sendEvent:(id<NSObject>)event;

@end

NS_ASSUME_NONNULL_END
