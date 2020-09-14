//
//  BBCHTTPNetworkReachabilityStatus.h
//  BBCHTTPClient
//
//  Created by Richard Price01 on 08/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;
#import "BBCHTTPNetworkStatus.h"
#import "BBCHTTPReachability.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkReachabilityStatus)
@interface BBCHTTPNetworkReachabilityStatus : NSObject <BBCHTTPNetworkStatus>
HTTP_CLIENT_INIT_UNAVAILABLE

- (instancetype)initWithReachabilityStatus:(BBCHTTPReachabilityStatus)reachabilityStatus;

@end

NS_ASSUME_NONNULL_END
