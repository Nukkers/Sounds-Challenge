//
//  BBCHTTPNetworkClient.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPDefaultUserAgent.h"
#import "BBCHTTPNetworkClient.h"
#import "BBCHTTPNetworkTask.h"
#import "BBCHTTPNetworkURLRequestBuilder.h"
#import "BBCHTTPNSURLSessionProviding.h"
#import "BBCHTTPDefaultNSURLSessionProvider.h"
#import "BBCHTTPNetworkClient+Internal.h"
#import "BBCHTTPNetworkTask+Internal.h"
#import "BBCHTTPURLSessionDelegate.h"
#import "BBCHTTPOperationQueueWorker.h"
#import "BBCHTTPNetworkClientContext.h"

@interface BBCHTTPNetworkClient ()

@property (strong, nonatomic) BBCHTTPURLSessionDelegate *sessionDelegate;

@end

#pragma mark -

@implementation BBCHTTPNetworkClient

- (void)dealloc
{
    [_urlSession invalidateAndCancel];
}

+ (BBCHTTPNetworkClient*)networkClient
{
    return [[self alloc] init];
}

+ (BBCHTTPNetworkClient*)networkClientWithAuthenticationDelegate:(id<BBCHTTPNetworkClientAuthenticationDelegate>)authenticationDelegate
{
    return [[self alloc] initWithAuthenticationDelegate:authenticationDelegate];
}

- (instancetype)initWithSessionProviding:(id<BBCHTTPNSURLSessionProviding>)sessionProviding
{
    self = [super init];
    if(self) {
        _context = [BBCHTTPNetworkClientContext new];
        _sessionDelegate = [[BBCHTTPURLSessionDelegate alloc] initWithContext:_context];
        _urlSession = [sessionProviding prepareSessionWithSessionDelegate:_sessionDelegate];
        _requestBuilder = [[BBCHTTPNetworkURLRequestBuilder alloc] init];
    }
    
    return self;
}

- (instancetype)initWithAuthenticationDelegate:(id<BBCHTTPNetworkClientAuthenticationDelegate>)authenticationDelegate
{
    if ((self = [self initWithSessionProviding:[BBCHTTPDefaultNSURLSessionProvider new]])) {
        _context.authenticationDelegate = authenticationDelegate;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithAuthenticationDelegate:nil];
}

- (void)setUserAgent:(id<BBCHTTPUserAgent>)userAgent
{
    [_requestBuilder setUserAgent:userAgent];
}

- (void)setRequestDecorators:(NSArray<id<BBCHTTPRequestDecorator> >*)requestDecorators
{
    [_requestBuilder setRequestDecorators:requestDecorators];
}

- (id<BBCHTTPTask>)sendRequest:(id<BBCHTTPRequest>)request
                       success:(BBCHTTPClientSuccess)success
                       failure:(BBCHTTPClientFailure)failure
{
    NSURLRequest* urlRequest = [_requestBuilder urlRequestWithRequest:request];
    for (id<BBCHTTPNetworkObserver> observer in _context.observers) {
        if ([observer respondsToSelector:@selector(willSendRequest:)]) {
            [observer willSendRequest:urlRequest];
        }
    }
    
    NSURLSessionDataTask* dataTask = [_urlSession dataTaskWithRequest:urlRequest];
    [dataTask resume];

    BBCHTTPNetworkTask *task = [BBCHTTPNetworkTask networkTaskWithSessionTask:dataTask];
    task.request = request;
    task.success = success;
    task.failure = failure;
    [_context.taskRegistry addTask:task];

    return task;
}

- (void)setResponseQueue:(dispatch_queue_t)responseQueue
{
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    operationQueue.underlyingQueue = responseQueue;
    [self setResponseOperationQueue:operationQueue];
}

- (void)setAcceptableStatusCodeRange:(NSRange)acceptableStatusCodeRange
{
    _context.acceptableStatusCodeRange = acceptableStatusCodeRange;
}

- (void)setObservers:(NSArray<id<BBCHTTPNetworkObserver>> *)observers
{
    _context.observers = observers;
}

- (void)setResponseOperationQueue:(NSOperationQueue *)responseOperationQueue
{
    _context.responseWorker = [[BBCHTTPOperationQueueWorker alloc] initWithOperationQueue:responseOperationQueue];
}

@end
