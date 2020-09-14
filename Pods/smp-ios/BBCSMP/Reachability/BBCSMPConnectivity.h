//
//  BBCSMPConnectivity.h
//  BBCSMP
//
//  Created by Raj Khokhar on 13/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPConnectivityObserver <NSObject>

- (void)connectivityChanged:(BOOL)isConnected;

@end

@protocol BBCSMPConnectivity <NSObject>

- (BOOL)isReachable;

- (void)addConnectivityObserver:(id<BBCSMPConnectivityObserver>)observer;
- (void)removeConnectivityObserver:(id<BBCSMPConnectivityObserver>)observer;

@end
