//
//  BBCHTTPRequest.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "BBCHTTPUserAgent.h"
#import "BBCHTTPRequestDecorator.h"
#import "BBCHTTPResponseProcessor.h"
#import "BBCHTTPMethod.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Request)
@protocol BBCHTTPRequest <NSObject>

@property (nonatomic, readonly) NSString * url;

@optional

@property (nonatomic, readonly, nullable) BBCHTTPMethod method;
@property (nonatomic, readonly, nullable) id<BBCHTTPUserAgent> userAgent;
@property (nonatomic, readonly, nullable) NSDictionary *headers;
@property (nonatomic, readonly, nullable) NSData * body;
@property (nonatomic, readonly) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, readonly) NSTimeInterval timeoutInterval;
@property (nonatomic, readonly, nullable) NSArray<id<BBCHTTPRequestDecorator>> *requestDecorators;
@property (nonatomic, readonly, nullable) NSArray<id<BBCHTTPResponseProcessor>> *responseProcessors;
@property (nonatomic, readonly, nullable) NSValue *acceptableStatusCodeRange; // Should be an [NSValue valueWithRange:]

@end

NS_ASSUME_NONNULL_END
