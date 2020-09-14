//
//  BBCHTTPURLSessionDelegate.m
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPURLSessionDelegate.h"
#import "BBCHTTPNetworkResponse.h"
#import "BBCHTTPNetworkError.h"
#import "BBCHTTPResponseWorker.h"
#import "BBCHTTPNetworkClientContext.h"
#import "BBCHTTPNetworkClientAuthenticationDelegate.h"
#import "BBCHTTPNetworkObserver.h"
#import "BBCHTTPNetworkTask+Internal.h"

@interface BBCHTTPURLSessionDelegate ()

@property (nonatomic, strong) BBCHTTPNetworkClientContext *context;

@end

#pragma mark -

@implementation BBCHTTPURLSessionDelegate

#pragma mark Initialization

- (instancetype)initWithContext:(BBCHTTPNetworkClientContext *)context
{
    self = [super init];
    if(self) {
        _context = context;
    }
    
    return self;
}

#pragma mark - NSURLSession Delegate Conformances

- (void)URLSession:(NSURLSession*)session didReceiveChallenge:(NSURLAuthenticationChallenge*)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential* __nullable credential))completionHandler
{
    if(_context.authenticationDelegate) {
        [_context.authenticationDelegate handleChallenge:challenge completionHandler:completionHandler];
    }
    else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // This is just here to suppress a warning
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    BBCHTTPNetworkTask *networkTask = [_context.taskRegistry networkTaskForSessionTask:dataTask];
    [networkTask updateProgressWithExpectedContentLength:response.expectedContentLength];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    [_context.taskRegistry networkTaskForSessionTask:dataTask].sessionTask = downloadTask;
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [[_context.taskRegistry networkTaskForSessionTask:dataTask] consumeReceivedData:data];
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    BBCHTTPNetworkTask *networkTask = [_context.taskRegistry networkTaskForSessionTask:task];
    [_context.taskRegistry removeTask:networkTask];
    NSMutableData *data = networkTask.accumulatedData;
    BBCHTTPClientSuccess success = networkTask.success;
    BBCHTTPClientFailure failure = networkTask.failure;
    
    if(!(success && failure)) {
        return;
    }
    
    id responseBody = nil;
    NSError* responseError = nil;
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)task.response;
    if (error) {
        for (id<BBCHTTPNetworkObserver> observer in _context.observers) {
            if ([observer respondsToSelector:@selector(didReceiveNetworkError:)]) {
                [observer didReceiveNetworkError:error];
            }
        }
        responseError = error;
    }
    else {
        for (id<BBCHTTPNetworkObserver> observer in _context.observers) {
            if ([observer respondsToSelector:@selector(didReceiveResponse:)]) {
                [observer didReceiveResponse:httpResponse];
            }
        }
        responseBody = data;
        NSMutableArray* responseProcessors = [[NSMutableArray alloc] init];
        if ([networkTask.request respondsToSelector:@selector(responseProcessors)] && networkTask.request.responseProcessors) {
            [responseProcessors addObjectsFromArray:networkTask.request.responseProcessors];
        }
        for (id<BBCHTTPResponseProcessor> responseProcessor in responseProcessors) {
            if (responseBody) {
                responseBody = [responseProcessor processResponse:responseBody error:&responseError];
            }
        }
        NSRange acceptableStatusCodeRange = _context.acceptableStatusCodeRange;
        if ([networkTask.request respondsToSelector:@selector(acceptableStatusCodeRange)]) {
            if (networkTask.request.acceptableStatusCodeRange) {
                acceptableStatusCodeRange = networkTask.request.acceptableStatusCodeRange.rangeValue;
            }
        }
        if (!NSLocationInRange(httpResponse.statusCode, acceptableStatusCodeRange)) {
            responseError = [NSError errorWithDomain:BBCHTTPNetworkClientErrorDomain code:httpResponse.statusCode userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Error getting URL - HTTP %ld", (long)httpResponse.statusCode] }];
        }
    }
    if (responseError) {
        [_context.responseWorker perform:^{
            failure(networkTask.request,
                    [BBCHTTPNetworkError networkErrorWithError:responseError
                                                  httpResponse:httpResponse
                                                          body:responseBody]);
        }];
    }
    else {
        [_context.responseWorker perform:^{
            success(networkTask.request,
                    [BBCHTTPNetworkResponse networkResponseWithResponse:httpResponse
                                                                   body:responseBody]);
        }];
    }
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    BBCHTTPNetworkTask *networkTask = [_context.taskRegistry networkTaskForSessionTask:downloadTask];
    [networkTask updateProgressWithTotalBytesWritten:totalBytesWritten
                           totalBytesExpectedToWrite:totalBytesExpectedToWrite];
}

@end
