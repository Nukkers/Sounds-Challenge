//
//  BBCHTTPNetworkError.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPNetworkError.h"

NSErrorDomain const BBCHTTPNetworkClientErrorDomain = @"BBCHTTPNetworkClient";

@interface BBCHTTPNetworkError ()

@property (strong,nonatomic) NSError *error;
@property (strong,nonatomic) NSHTTPURLResponse *httpResponse;
@property (strong,nonatomic) id body;

@end

#pragma mark -

@implementation BBCHTTPNetworkError

+ (BBCHTTPNetworkError *)networkErrorWithError:(NSError *)error httpResponse:(NSHTTPURLResponse *)httpResponse body:(id)body
{
    return [[self alloc] initWithError:error httpResponse:httpResponse body:body];
}

- (instancetype)initWithError:(NSError *)error httpResponse:(NSHTTPURLResponse *)httpResponse body:(id)body
{
    if ((self = [super init])) {
        _error = error;
        _httpResponse = httpResponse;
        _body = body;
    }

    return self;
}

- (NSInteger)statusCode
{
    return _httpResponse.statusCode;
}

- (NSDictionary *)headers
{
    return _httpResponse.allHeaderFields;
}

- (NSString *)description
{
    NSMutableDictionary *descriptionDictionary = [NSMutableDictionary dictionary];
    if (_error) {
        descriptionDictionary[@"error"] = _error.description;
    }

    if (_httpResponse) {
        descriptionDictionary[@"httpResponse"] = _httpResponse.description;
    }

    if (_body) {
        descriptionDictionary[@"body"] = [_body description];
    }

    return [NSString stringWithFormat:@"%@ <%@>",super.description,descriptionDictionary.description];
}

@end
