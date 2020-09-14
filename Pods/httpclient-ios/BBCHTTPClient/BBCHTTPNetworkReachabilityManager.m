//
//  BBCHTTPNetworkReachabilityManager.m
//  BBCHTTPClient
//
//  Created by Richard Price01 on 08/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPNetworkReachabilityManager.h"
#import "BBCHTTPNetworkReachabilityStatus.h"
#import "BBCHTTPReachability.h"
#import "BBCHTTPNetworkStatus.h"

NSString* const BBCHTTPNetworkReachabilityStatusDidChangeNotification = @"BBCHTTPNetworkReachabilityStatusDidChangeNotification";
NSString* const BBCHTTPNetworkReachabilityStatusDidChangeNotificationStatusKey = @"BBCHTTPNetworkReachabilityStatusDidChangeNotificationStatusKey";

@interface BBCHTTPNetworkReachabilityManager ()

@property (strong, nonatomic) BBCHTTPReachability* networkReachability;
@property (strong, nonatomic) BBCHTTPNetworkReachabilityStatus* networkStatus;

@end

#pragma mark -

@implementation BBCHTTPNetworkReachabilityManager

- (instancetype)init
{
    if ((self = [super init])) {
        _networkReachability = [BBCHTTPReachability reachabilityForInternetConnection];
        [_networkReachability startNotifier];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityDidChange:) name:kBBCHTTPReachabilityChangedNotification object:nil];

        _networkStatus = [[BBCHTTPNetworkReachabilityStatus alloc] initWithReachabilityStatus:_networkReachability.currentReachabilityStatus];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBBCHTTPReachabilityChangedNotification object:nil];
}

- (void)networkReachabilityDidChange:(NSNotification*)notification
{
    // Do not change this assignment to use backing field directly!
    self.networkStatus = [[BBCHTTPNetworkReachabilityStatus alloc] initWithReachabilityStatus:_networkReachability.currentReachabilityStatus];
}

- (BBCHTTPNetworkReachabilityStatus*)status
{
    return _networkStatus;
}

- (void)setNetworkStatus:(BBCHTTPNetworkReachabilityStatus*)networkStatus
{
    if ([_networkStatus isEqual:networkStatus])
        return;

    _networkStatus = networkStatus;
    if (_networkStatus) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BBCHTTPNetworkReachabilityStatusDidChangeNotification object:self userInfo:@{ BBCHTTPNetworkReachabilityStatusDidChangeNotificationStatusKey : _networkStatus }];
    }
}

@end
