//
//  BBCHTTPNetworkTaskRegistry.m
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 26/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCHTTPNetworkTaskRegistry.h"
#import "BBCHTTPNetworkTask+Internal.h"

@implementation BBCHTTPNetworkTaskRegistry {
    NSMutableArray<BBCHTTPNetworkTask *> *_networkTasks;
    NSRecursiveLock *_mutationLock;
}

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if(self) {
        _networkTasks = [NSMutableArray array];
        _mutationLock = [[NSRecursiveLock alloc] init];
    }
    
    return self;
}

#pragma mark Public

- (NSUInteger)count
{
    return _networkTasks.count;
}

- (void)addTask:(BBCHTTPNetworkTask *)task
{
    [_mutationLock lock];
    [_networkTasks addObject:task];
    [_mutationLock unlock];
}

- (void)removeTask:(BBCHTTPNetworkTask *)task
{
    [_mutationLock lock];
    [_networkTasks removeObject:task];
    [_mutationLock unlock];
}

- (BBCHTTPNetworkTask *)networkTaskForSessionTask:(NSURLSessionTask *)sessionTask
{
    [_mutationLock lock];
    
    BBCHTTPNetworkTask *networkTask;
    for(BBCHTTPNetworkTask *task in _networkTasks) {
        if(task.sessionTask == sessionTask) {
            networkTask = task;
        }
    }
    
    [_mutationLock unlock];
    
    return networkTask;
}

@end
