//
//  BBCSMPNetworkStatus.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 29/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPNetworkStatus.h>
#import "BBCSMPNetworkStatus.h"

@interface BBCSMPNetworkStatus ()

@property (nonatomic, strong) id<BBCHTTPNetworkStatus> reachabilityStatus;

@end

@implementation BBCSMPNetworkStatus

+ (instancetype)networkStatusWithReachabilityStatus:(id<BBCHTTPNetworkStatus>)reachabilityStatus
{
    return [[self alloc] initWithReachabilityStatus:reachabilityStatus];
}

- (instancetype)initWithReachabilityStatus:(id<BBCHTTPNetworkStatus>)reachabilityStatus
{
    if ((self = [super init])) {
        _reachabilityStatus = reachabilityStatus;
    }
    return self;
}

- (BOOL)reachable
{
    return _reachabilityStatus.reachable;
}

- (BOOL)reachableViaWifi
{
    return _reachabilityStatus.reachableViaWifi;
}

- (BOOL)reachableViaWWAN
{
    return _reachabilityStatus.reachableViaWWAN;
}

@end
