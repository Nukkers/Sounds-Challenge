//
//  BBCHTTPNetworkReachabilityManager.h
//  BBCHTTPClient
//
//  Created by Richard Price01 on 08/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol BBCHTTPNetworkStatus;

FOUNDATION_EXTERN NSNotificationName const BBCHTTPNetworkReachabilityStatusDidChangeNotification NS_SWIFT_NAME(NetworkReachabilityStatusDidChange);
FOUNDATION_EXTERN NSString *const BBCHTTPNetworkReachabilityStatusDidChangeNotificationStatusKey NS_SWIFT_NAME(NetworkReachabilityStatusDidChangeNotificationStatusKey);

NS_SWIFT_NAME(NetworkReachabilityManager)
@interface BBCHTTPNetworkReachabilityManager : NSObject

@property (readonly) id<BBCHTTPNetworkStatus> status;

@end

NS_ASSUME_NONNULL_END
