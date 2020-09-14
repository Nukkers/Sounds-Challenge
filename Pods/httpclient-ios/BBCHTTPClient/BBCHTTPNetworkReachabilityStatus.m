//
//  BBCHTTPNetworkReachabilityStatus.m
//  BBCHTTPClient
//
//  Created by Richard Price01 on 08/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPNetworkReachabilityStatus.h"

@interface BBCHTTPNetworkReachabilityStatus ()

@property (nonatomic) BBCHTTPReachabilityStatus reachabilityStatus;

@end

#pragma mark -

@implementation BBCHTTPNetworkReachabilityStatus

- (instancetype)initWithReachabilityStatus:(BBCHTTPReachabilityStatus)reachabilityStatus
{
    if ((self = [super init])) {
        _reachabilityStatus = reachabilityStatus;
    }

    return self;
}

- (NSString*)description
{
    NSString* statusString = nil;
    switch (_reachabilityStatus) {
    case BBCHTTPNotReachable: {
        statusString = @"Not reachable";
        break;
    }
    case BBCHTTPReachableViaWiFi: {
        statusString = @"Reachable via WiFi";
        break;
    }
    case BBCHTTPReachableViaWWAN: {
        statusString = @"Reachable via WWAN";
        break;
    }
    }

    return [NSString stringWithFormat:@"%@ : %@", super.description, statusString];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    BBCHTTPNetworkReachabilityStatus* otherStatus = (BBCHTTPNetworkReachabilityStatus*)object;
    return otherStatus.reachabilityStatus == self.reachabilityStatus;
}

- (BOOL)reachable
{
    return _reachabilityStatus != BBCHTTPNotReachable;
}

- (BOOL)reachableViaWifi
{
    return _reachabilityStatus == BBCHTTPReachableViaWiFi;
}

- (BOOL)reachableViaWWAN
{
    return _reachabilityStatus == BBCHTTPReachableViaWWAN;
}

@end
