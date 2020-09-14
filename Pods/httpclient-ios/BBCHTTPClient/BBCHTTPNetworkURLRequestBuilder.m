//
//  BBCHTTPNetworkURLRequestBuilder.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 29/09/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPNetworkURLRequestBuilder.h"
#import "BBCHTTPDefaultUserAgent.h"

@implementation BBCHTTPNetworkURLRequestBuilder

static NSString *const BBCHTTPUserAgentHeaderField = @"User-Agent";

- (instancetype)init
{
    if ((self = [super init])) {
        _userAgent = [BBCHTTPDefaultUserAgent defaultUserAgent];
        _requestDecorators = @[];
    }

    return self;
}

- (NSURLRequest *)urlRequestWithRequest:(id<BBCHTTPRequest>)request
{
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.url]];
    if ([request respondsToSelector:@selector(userAgent)] && request.userAgent) {
        [mutableRequest setValue:request.userAgent.userAgent forHTTPHeaderField:BBCHTTPUserAgentHeaderField];
    }
    else {
        [mutableRequest setValue:_userAgent.userAgent forHTTPHeaderField:BBCHTTPUserAgentHeaderField];
    }

    if ([request respondsToSelector:@selector(method)]) {
        mutableRequest.HTTPMethod = request.method;
    }

    if ([request respondsToSelector:@selector(body)]) {
        mutableRequest.HTTPBody = request.body;
    }

    if ([request respondsToSelector:@selector(headers)]) {
        for (NSString *key in request.headers.allKeys) {
            [mutableRequest addValue:request.headers[key] forHTTPHeaderField:key];
        }
    }

    if ([request respondsToSelector:@selector(cachePolicy)]) {
        mutableRequest.cachePolicy = request.cachePolicy;
    }

    if ([request respondsToSelector:@selector(timeoutInterval)]) {
        mutableRequest.timeoutInterval = request.timeoutInterval;
    }

    NSURLRequest *immutableRequest = [mutableRequest copy];
    NSMutableArray *consolidatedRequestDecorators = _requestDecorators ? [_requestDecorators mutableCopy] : [NSMutableArray array];
    if ([request respondsToSelector:@selector(requestDecorators)] && request.requestDecorators) {
        [consolidatedRequestDecorators addObjectsFromArray:request.requestDecorators];
    }

    for (id<BBCHTTPRequestDecorator> requestDecorator in consolidatedRequestDecorators) {
        immutableRequest = [requestDecorator decorateRequest:immutableRequest];
    }

    return immutableRequest;
}

@end
