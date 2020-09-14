//
//  BBCHTTPNetworkResponse.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPNetworkResponse.h"

@interface BBCHTTPNetworkResponse ()

@property (strong,nonatomic) NSHTTPURLResponse *httpResponse;
@property (strong,nonatomic) id body;

@end

#pragma mark -

@implementation BBCHTTPNetworkResponse

+ (BBCHTTPNetworkResponse *)networkResponseWithResponse:(NSHTTPURLResponse *)response body:(id)body
{
    return [[self alloc] initWithResponse:response body:body];
}

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response body:(id)body
{
    if ((self = [super init])) {
        _body = body;
        _httpResponse = response;
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
    if (_httpResponse) {
        descriptionDictionary[@"httpResponse"] = _httpResponse.description;
    }

    if (_body) {
        descriptionDictionary[@"body"] = [_body description];
    }

    return [NSString stringWithFormat:@"%@ <%@>",super.description,descriptionDictionary.description];
}

@end
