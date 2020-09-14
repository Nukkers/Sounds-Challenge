//
//  BBCSMPReachabilityManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 29/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPNetworkStatusProvider.h"
#import "BBCSMPConnectivity.h"

@class BBCSMPNetworkStatusManager;
@class BBCHTTPNetworkReachabilityManager;
@protocol BBCSMPNetworkStatusObserver;

@interface BBCSMPNetworkStatusManager : NSObject <BBCSMPNetworkStatusProvider,BBCSMPConnectivity>

@property (nonatomic, strong, readonly) BBCSMPNetworkStatus* status;

+ (instancetype)sharedManager;

- (instancetype)initWithNetworkReachabilityManager:(BBCHTTPNetworkReachabilityManager *)networkReachabilityManager NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(id<BBCSMPNetworkStatusObserver>)observer;
- (void)removeObserver:(id<BBCSMPNetworkStatusObserver>)observer;

@end
