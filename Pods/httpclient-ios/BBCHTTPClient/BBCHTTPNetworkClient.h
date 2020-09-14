//
//  BBCHTTPNetworkClient.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPClient.h"
#import "BBCHTTPNetworkClientAuthenticationDelegate.h"
#import "BBCHTTPNetworkObserver.h"
#import "BBCHTTPRequestDecorator.h"
#import "BBCHTTPResponseProcessor.h"
#import "BBCHTTPURLRequestBuilder.h"
#import "BBCHTTPUserAgent.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkClient)
@interface BBCHTTPNetworkClient : NSObject <BBCHTTPClient>

@property (class, NS_NONATOMIC_IOSONLY, readonly) BBCHTTPNetworkClient *networkClient NS_REFINED_FOR_SWIFT;

+ (instancetype)networkClientWithAuthenticationDelegate:(nullable id<BBCHTTPNetworkClientAuthenticationDelegate>)authenticationDelegate;

@property (strong, nonatomic) id<BBCHTTPURLRequestBuilder> requestBuilder; // Default is a BBCHTTPNetworkURLRequestBuilder

- (instancetype)initWithURLSession:(NSURLSession*)urlSession HTTP_CLIENT_UNAVAILABLE("use -init or -initWithAuthenticationDelegate: instead");
- (instancetype)initWithAuthenticationDelegate:(nullable id<BBCHTTPNetworkClientAuthenticationDelegate>)authenticationDelegate;

- (void)setUserAgent:(nullable id<BBCHTTPUserAgent>)userAgent NS_SWIFT_NAME(set(userAgent:));
- (void)setResponseOperationQueue:(NSOperationQueue *)responseOperationQueue NS_SWIFT_NAME(set(responseOperationQueue:));
- (void)setAcceptableStatusCodeRange:(NSRange)acceptableStatusCodeRange NS_SWIFT_NAME(set(acceptableStatusCodeRange:));
- (void)setRequestDecorators:(nullable NSArray<id<BBCHTTPRequestDecorator> >*)requestDecorators NS_SWIFT_NAME(set(requestDecorators:));
- (void)setObservers:(nullable NSArray<id<BBCHTTPNetworkObserver> >*)observers NS_SWIFT_NAME(set(observers:));


#pragma mark Deprecated

- (void)setResponseQueue:(dispatch_queue_t)responseQueue NS_SWIFT_NAME(set(responseQueue:)) HTTP_CLIENT_DEPRECATED("Supply an NSOperationQueue using -[BBCHTTPClient setResponseOperationQueue:] instead");

@end

NS_ASSUME_NONNULL_END
