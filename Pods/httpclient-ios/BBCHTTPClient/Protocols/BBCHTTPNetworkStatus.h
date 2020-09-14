//
//  BBCHTTPNetworkStatus.h
//  BBCHTTPClient
//
//  Created by Richard Price01 on 08/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_SWIFT_NAME(NetworkStatus)
@protocol BBCHTTPNetworkStatus <NSObject>

@property (nonatomic, readonly) BOOL reachable;
@property (nonatomic, readonly) BOOL reachableViaWifi;
@property (nonatomic, readonly) BOOL reachableViaWWAN;

@end
