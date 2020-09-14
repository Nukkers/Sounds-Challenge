//
//  BBCHTTPReachabilityDeviceSpecific-iOS.m
//  BBCHTTPClient
//
//  Created by Timothy James Condon on 09/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCHTTPReachabilityDeviceSpecific.h"

@implementation BBCHTTPReachabilityDeviceSpecific

+ (BBCHTTPReachabilityStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags withCurrentReturnValue:(BBCHTTPReachabilityStatus)currentReturnValue
{
    BBCHTTPReachabilityStatus returnValue = currentReturnValue;
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
        /*
            ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
        */
        returnValue = BBCHTTPReachableViaWWAN;
    }
    
    return returnValue;
}


@end