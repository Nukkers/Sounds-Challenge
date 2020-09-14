//
//  BBCSMPNetworkStatus.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 29/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HTTPClient/BBCHTTPNetworkStatus.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPNetworkStatus : NSObject <BBCHTTPNetworkStatus>

+ (instancetype)networkStatusWithReachabilityStatus:(id<BBCHTTPNetworkStatus>)reachabilityStatus NS_SWIFT_NAME(networkStatus(reachabilityStatus:));

@end

NS_ASSUME_NONNULL_END
