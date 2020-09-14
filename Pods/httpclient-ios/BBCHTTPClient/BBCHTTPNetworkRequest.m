//
//  BBCHTTPNetworkRequest.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPNetworkRequest.h"

@interface BBCHTTPNetworkRequest ()

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) BBCHTTPMethod method;
@property (nonatomic, strong) id<BBCHTTPUserAgent> userAgent;
@property (nonatomic, strong) NSDictionary *headers;
@property (nonatomic, strong) NSData *body;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, strong) NSArray<id<BBCHTTPRequestDecorator>> *requestDecorators;
@property (nonatomic, strong) NSArray<id<BBCHTTPResponseProcessor>> *responseProcessors;
@property (nonatomic, strong) NSValue *acceptableStatusCodeRange;

@end

#pragma mark -

@implementation BBCHTTPNetworkRequest

const NSTimeInterval BBCHTTPNetworkRequestDefaultTimeout = 30.0;

+ (BBCHTTPNetworkRequest *)requestWithString:(NSString *)urlString
{
    return [[self alloc] initWithString:urlString];
}

+ (BBCHTTPNetworkRequest *)requestWithURL:(NSURL *)url
{
    return [[self alloc] initWithURL:url];
}

+ (BBCHTTPNetworkRequest *)requestWithURLRequest:(NSURLRequest *)urlRequest
{
    return [[self alloc] initWithURLRequest:urlRequest];
}

- (instancetype)initWithString:(NSString *)urlString
{
    if ((self = [super init])) {
        _url = urlString;
        _method = BBCHTTPMethodGET;
        _headers = @{};
        _cachePolicy = NSURLRequestUseProtocolCachePolicy;
        _timeoutInterval = BBCHTTPNetworkRequestDefaultTimeout;
    }

    return self;
}

- (instancetype)initWithURL:(NSURL *)url
{
    return [self initWithString:url.absoluteString];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)urlRequest
{
    if ((self = [self initWithString:urlRequest.URL.absoluteString])) {
        _method = urlRequest.HTTPMethod;
        _headers = urlRequest.allHTTPHeaderFields;
        _body = urlRequest.HTTPBody;
        _cachePolicy = urlRequest.cachePolicy;
        _timeoutInterval = urlRequest.timeoutInterval;
    }

    return self;
}

- (instancetype)withMethod:(BBCHTTPMethod)method
{
    _method = method;
    return self;
}

- (instancetype)withUserAgent:(id<BBCHTTPUserAgent>)userAgent
{
    _userAgent = userAgent;
    return self;
}

- (instancetype)withHeaders:(NSDictionary *)headers
{
    _headers = headers;
    return self;
}

- (instancetype)withBody:(NSData *)body
{
    _body = body;
    return self;
}

- (instancetype)withCachePolicy:(NSURLRequestCachePolicy)cachePolicy
{
    _cachePolicy = cachePolicy;
    return self;
}

- (instancetype)withTimeoutInterval:(NSTimeInterval)timeoutInterval
{
    _timeoutInterval = timeoutInterval;
    return self;
}

- (instancetype)withRequestDecorators:(NSArray<id<BBCHTTPRequestDecorator>> *)requestDecorators
{
    _requestDecorators = requestDecorators;
    return self;
}

- (instancetype)withResponseProcessors:(NSArray<id<BBCHTTPResponseProcessor>> *)responseProcessors
{
    _responseProcessors = responseProcessors;
    return self;
}

- (instancetype)withAcceptableStatusCodeRange:(NSRange)acceptableStatusCodeRange
{
    _acceptableStatusCodeRange = [NSValue valueWithRange:acceptableStatusCodeRange];
    return self;
}

- (NSString *)description
{
    NSMutableString *requestDescription = [NSMutableString stringWithFormat:@"%@ %@",_method,_url];
    for (NSString *headerName in _headers.allKeys) {
        [requestDescription appendFormat:@"\n%@: %@",headerName,_headers[headerName]];
    }

    if (_body) {
        [requestDescription appendFormat:@"\nBody is %lu bytes",(unsigned long)_body.length];
    }

    if (_requestDecorators) {
        [requestDescription appendFormat:@"\n%ld request decorators",(unsigned long)_requestDecorators.count];
    }

    if (_responseProcessors) {
        [requestDescription appendFormat:@"\n%ld response processors",(unsigned long)_responseProcessors.count];
    }

    return [NSString stringWithFormat:@"%@ <%@>",super.description,requestDescription];
}

@end
