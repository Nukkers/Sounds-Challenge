//
//  BBCSMPAccessibilityStateProviding.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 06/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAccessibilityStateObserver;

@protocol BBCSMPAccessibilityStateProviding <NSObject>
@required

- (void)addObserver:(id<BBCSMPAccessibilityStateObserver>)observer;

@end

NS_ASSUME_NONNULL_END
