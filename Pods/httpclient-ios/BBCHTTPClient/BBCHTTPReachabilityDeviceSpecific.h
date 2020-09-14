//
//  BBCHTTPReachabilityDeviceSpecific.h
//  BBCHTTPClient
//
//  Created by Timothy James Condon on 09/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPReachability.h"

NS_SWIFT_NAME(ReachabilityDeviceSpecific)
@interface BBCHTTPReachabilityDeviceSpecific : NSObject

+ (BBCHTTPReachabilityStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags
                            withCurrentReturnValue:(BBCHTTPReachabilityStatus)currentReturnValue;

@end
