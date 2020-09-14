//
//  BBCHTTPURLRequestBuilder.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 29/09/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPRequest.h"
#import "BBCHTTPUserAgent.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(URLRequestBuilder)
@protocol BBCHTTPURLRequestBuilder <NSObject>

- (void)setUserAgent:(id<BBCHTTPUserAgent>)userAgent NS_SWIFT_NAME(set(userAgent:));
- (void)setRequestDecorators:(NSArray<id<BBCHTTPRequestDecorator>> *)requestDecorators NS_SWIFT_NAME(set(requestDecorators:));

- (NSURLRequest *)urlRequestWithRequest:(id<BBCHTTPRequest>)request;

@end

NS_ASSUME_NONNULL_END
