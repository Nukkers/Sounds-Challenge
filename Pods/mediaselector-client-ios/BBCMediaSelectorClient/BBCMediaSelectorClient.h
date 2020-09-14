//
//  BBCMediaSelectorClient.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaSelectorConfiguring.h"
#import "BBCMediaSelectorErrors.h"
#import "BBCMediaSelectorRequest.h"
#import "BBCMediaSelectorResponse.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCWorker;
@protocol BBCHTTPClient;
@protocol BBCMediaSelectorRandomization;

NS_SWIFT_NAME(MediaSelectorClientResponseBlock)
typedef void (^BBCMediaSelectorClientResponseBlock)(BBCMediaSelectorResponse* response);

NS_SWIFT_NAME(MediaSelectorClientURLBlock)
typedef void (^BBCMediaSelectorClientURLBlock)(NSURL* url);

NS_SWIFT_NAME(MediaSelectorClientFailureBlock)
typedef void (^BBCMediaSelectorClientFailureBlock)(NSError* error);

#pragma mark -

NS_SWIFT_NAME(MediaSelectorClient)
@interface BBCMediaSelectorClient : NSObject

#pragma mark Client Builders

@property (class, nonatomic, strong, readonly) BBCMediaSelectorClient *sharedClient NS_REFINED_FOR_SWIFT;

- (instancetype)withConfiguring:(id<BBCMediaSelectorConfiguring>)configuring NS_SWIFT_NAME(with(configuration:));
- (instancetype)withHTTPClient:(id<BBCHTTPClient>)httpClient NS_SWIFT_NAME(with(httpClient:));
- (instancetype)withRandomiser:(id<BBCMediaSelectorRandomization>)randomiser NS_SWIFT_NAME(with(randomiser:));
- (instancetype)withResponseWorker:(id<BBCWorker>)worker NS_SWIFT_NAME(with(responseWorker:));


#pragma mark Request Handling

- (void)sendMediaSelectorRequest:(BBCMediaSelectorRequest*)request
                         success:(BBCMediaSelectorClientResponseBlock)success
                         failure:(BBCMediaSelectorClientFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
