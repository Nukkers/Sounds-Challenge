//
//  BBCSMPReachabilityManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 29/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPNetworkReachabilityManager.h>
#import "BBCSMPNetworkStatusManager.h"
#import "BBCSMPNetworkStatusObserver.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPNetworkStatus.h"

@interface BBCSMPNetworkStatusManager ()

@property (nonatomic, strong) BBCSMPNetworkStatus* networkStatus;
@property (nonatomic, strong) BBCSMPObserverManager* observerManager;
@property (nonatomic, strong) BBCHTTPNetworkReachabilityManager* reachabilityManager;

@end

@implementation BBCSMPNetworkStatusManager {
    NSMutableArray<id<BBCSMPConnectivityObserver>> *_connectivityObservers;
}

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static BBCSMPNetworkStatusManager* sharedManager;
    dispatch_once(&once, ^{
        sharedManager = [[BBCSMPNetworkStatusManager alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    return self = [self initWithNetworkReachabilityManager:[[BBCHTTPNetworkReachabilityManager alloc] init]];
}

- (instancetype)initWithNetworkReachabilityManager:(BBCHTTPNetworkReachabilityManager *)networkReachabilityManager
{
    self = [super init];
    if (self) {
        _observerManager = [[BBCSMPObserverManager alloc] init];
        _connectivityObservers = [NSMutableArray array];
        _reachabilityManager = networkReachabilityManager;
        _networkStatus = [BBCSMPNetworkStatus networkStatusWithReachabilityStatus:self.reachabilityManager.status];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityDidChange:) name:BBCHTTPNetworkReachabilityStatusDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BBCHTTPNetworkReachabilityStatusDidChangeNotification object:nil];
}

- (BBCSMPNetworkStatus*)status
{
    return _networkStatus;
}

#pragma mark - Reachability updating

- (void)networkReachabilityDidChange:(NSNotification*)notification
{
    [self setNetworkStatus:[BBCSMPNetworkStatus networkStatusWithReachabilityStatus:self.reachabilityManager.status]];
}

- (void)setNetworkStatus:(BBCSMPNetworkStatus*)networkStatus
{
    if ([_networkStatus isEqual:networkStatus])
        return;

    _networkStatus = networkStatus;
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPNetworkStatusObserver)
                                       withBlock:^(id<BBCSMPNetworkStatusObserver> observer) {
                                           [observer networkStatusChanged:weakSelf.networkStatus];
                                       }];
    
    for (id<BBCSMPConnectivityObserver> observer in _connectivityObservers) {
        [observer connectivityChanged:networkStatus.reachable];
    }
}

- (void)addObserver:(id<BBCSMPNetworkStatusObserver>)observer
{
    [_observerManager addObserver:observer];
}

- (void)removeObserver:(id<BBCSMPNetworkStatusObserver>)observer
{
    [_observerManager removeObserver:observer];
}

- (BOOL) isReachable {
    return self.networkStatus.reachable;
}

- (void)addConnectivityObserver:(id<BBCSMPConnectivityObserver>)observer
{
    [_connectivityObservers addObject:observer];
}

- (void)removeConnectivityObserver:(id<BBCSMPConnectivityObserver>)observer
{
    [_connectivityObservers removeObject:observer];
}

@end
