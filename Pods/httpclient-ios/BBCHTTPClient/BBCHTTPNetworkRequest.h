//
//  BBCHTTPNetworkRequest.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPRequest.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN const NSTimeInterval BBCHTTPNetworkRequestDefaultTimeout;

NS_SWIFT_NAME(NetworkRequest)
@interface BBCHTTPNetworkRequest : NSObject <BBCHTTPRequest>
HTTP_CLIENT_INIT_UNAVAILABLE

+ (instancetype)requestWithString:(NSString *)urlString;
+ (instancetype)requestWithURL:(NSURL *)url;
+ (instancetype)requestWithURLRequest:(NSURLRequest *)urlRequest;

- (instancetype)initWithString:(NSString *)urlString NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURLRequest:(NSURLRequest *)urlRequest;

- (instancetype)withMethod:(BBCHTTPMethod)method NS_SWIFT_NAME(with(method:));
- (instancetype)withUserAgent:(nullable id<BBCHTTPUserAgent>)userAgent NS_SWIFT_NAME(with(userAgent:));
- (instancetype)withHeaders:(nullable NSDictionary *)headers NS_SWIFT_NAME(with(headers:));
- (instancetype)withBody:(nullable NSData *)body NS_SWIFT_NAME(with(body:));
- (instancetype)withCachePolicy:(NSURLRequestCachePolicy)cachePolicy NS_SWIFT_NAME(with(cachePolicy:));
- (instancetype)withTimeoutInterval:(NSTimeInterval)timeoutInterval NS_SWIFT_NAME(with(timeoutInterval:));
- (instancetype)withRequestDecorators:(nullable NSArray<id<BBCHTTPRequestDecorator>> *)requestDecorators NS_SWIFT_NAME(with(requestDecorators:));
- (instancetype)withResponseProcessors:(nullable NSArray<id<BBCHTTPResponseProcessor>> *)responseProcessors NS_SWIFT_NAME(with(responseProcessors:));
- (instancetype)withAcceptableStatusCodeRange:(NSRange)acceptableStatusCodeRange NS_SWIFT_NAME(with(acceptableStatusCodeRange:));

@end

NS_ASSUME_NONNULL_END
