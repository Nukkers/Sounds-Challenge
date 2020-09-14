//
//  BBCHTTPCapturingNetworkObserver.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPCapturingNetworkObserver.h"

@interface BBCHTTPCapturingNetworkObserver ()

@property (strong, nonatomic) NSMutableArray<NSURLRequest*>* mutableRequests;
@property (strong, nonatomic) NSMutableArray<NSError*>* mutableErrors;
@property (strong, nonatomic) NSMutableArray<NSHTTPURLResponse*>* mutableResponses;

@end

#pragma mark -

@implementation BBCHTTPCapturingNetworkObserver

- (instancetype)init
{
    if ((self = [super init])) {
        _mutableRequests = [NSMutableArray array];
        _mutableErrors = [NSMutableArray array];
        _mutableResponses = [NSMutableArray array];
    }

    return self;
}

- (NSArray<NSURLRequest*>*)requests
{
    return [NSArray arrayWithArray:_mutableRequests];
}

- (NSArray<NSError*>*)errors
{
    return [NSArray arrayWithArray:_mutableErrors];
}

- (NSArray<NSHTTPURLResponse*>*)responses
{
    return [NSArray arrayWithArray:_mutableResponses];
}

- (NSURLRequest*)lastRequest
{
    return [_mutableRequests lastObject];
}

- (NSError*)lastError
{
    return [_mutableErrors lastObject];
}

- (NSHTTPURLResponse*)lastResponse
{
    return [_mutableResponses lastObject];
}

- (void)clearRequests
{
    [_mutableRequests removeAllObjects];
}

- (void)clearErrors
{
    [_mutableErrors removeAllObjects];
}

- (void)clearResponses
{
    [_mutableResponses removeAllObjects];
}

- (void)clearAll
{
    [self clearRequests];
    [self clearErrors];
    [self clearResponses];
}

#pragma mark - BBCHTTPNetworkObserver

- (void)willSendRequest:(NSURLRequest*)request
{
    if (!request) {
        return;
    }
    
    [_mutableRequests addObject:request];
}

- (void)didReceiveNetworkError:(NSError*)error
{
    if (!error) {
        return;
    }
    
    [_mutableErrors addObject:error];
}

- (void)didReceiveResponse:(NSHTTPURLResponse*)response
{
    if (!response) {
        return;
    }
    
    [_mutableResponses addObject:response];
}

@end
