//
//  BBCHTTPNetworkTask+Internal.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood on 30/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPNetworkTask.h"
#import "BBCHTTPClient.h"

@protocol BBCHTTPRequest;

NS_ASSUME_NONNULL_BEGIN

@interface BBCHTTPNetworkTask ()

@property (nonatomic, strong) NSURLSessionTask *sessionTask;
@property (nonatomic, strong) NSMutableData *accumulatedData;
@property (nonatomic, strong) id<BBCHTTPRequest> request;
@property (nonatomic, copy) BBCHTTPClientSuccess success;
@property (nonatomic, copy) BBCHTTPClientFailure failure;

- (void)updateProgressWithTotalBytesWritten:(int64_t)totalBytesWritten
                  totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;
- (void)consumeReceivedData:(NSData *)data;
- (void)updateProgressWithExpectedContentLength:(long long)expectedContentLength;

@end

NS_ASSUME_NONNULL_END
