//
//  BBCHTTPNetworkTask.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 05/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPNetworkTask.h"
#import "BBCHTTPNetworkTask+Internal.h"

@interface BBCHTTPNetworkTask ()

@property (strong) NSProgress *progress;

@end

#pragma mark -

@implementation BBCHTTPNetworkTask

#pragma mark Class Methods

+ (BBCHTTPNetworkTask *)networkTaskWithSessionTask:(NSURLSessionTask *)sessionTask
{
    return [[self alloc] initWithSessionTask:sessionTask];
}


#pragma mark Initialization

- (instancetype)initWithSessionTask:(NSURLSessionTask *)sessionTask
{
    self = [super init];
    if (self) {
        _sessionTask = sessionTask;
        _accumulatedData = [NSMutableData data];
        
        _progress = [NSProgress new];
        _progress.kind = NSProgressKindFile;
        [_progress setUserInfoObject:NSProgressFileOperationKindDownloading
                              forKey:NSProgressFileOperationKindKey];
        _progress.cancellationHandler = ^{
            [sessionTask cancel];
        };
    }

    return self;
}


#pragma mark BBCHTTPTask

- (void)cancel
{
    [_sessionTask cancel];
}


#pragma mark Internal

- (void)updateProgressWithTotalBytesWritten:(int64_t)totalBytesWritten
                  totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    _progress.totalUnitCount = totalBytesExpectedToWrite;
    _progress.completedUnitCount = totalBytesWritten;
}

- (void)consumeReceivedData:(NSData *)data
{
    [_accumulatedData appendData:data];
    _progress.completedUnitCount = (int64_t)_accumulatedData.length;
}

- (void)updateProgressWithExpectedContentLength:(long long)expectedContentLength
{
    _progress.totalUnitCount = expectedContentLength;
}

@end
