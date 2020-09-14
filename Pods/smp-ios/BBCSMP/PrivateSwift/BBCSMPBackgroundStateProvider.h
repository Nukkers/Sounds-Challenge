//
//  BBCSMPBackgroundStateProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/04/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPBackgroundObserver;

@protocol BBCSMPBackgroundStateProvider <NSObject>
@required

- (void)addObserver:(id<BBCSMPBackgroundObserver>)observer NS_SWIFT_NAME(add(observer:));
- (void)removeObserver:(id<BBCSMPBackgroundObserver>)observer NS_SWIFT_NAME(remove(observer:));

@end

NS_ASSUME_NONNULL_END
