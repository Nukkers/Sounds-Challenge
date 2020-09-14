//
//  BBCMediaSelectorRequestHeadersBuilder.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 27/07/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

#import "BBCMediaSelectorRequestHeadersBuilder.h"

@interface BBCMediaSelectorRequest ()

@property (strong,nonatomic) NSString *samlToken;

@end

@interface BBCMediaSelectorRequestHeadersBuilder ()

@property (weak,nonatomic) id<BBCMediaSelectorConfiguring> configuring;

@end

@implementation BBCMediaSelectorRequestHeadersBuilder

- (instancetype)initWithConfiguring:(id<BBCMediaSelectorConfiguring>)configuring
{
    if ((self = [super init])) {
        self.configuring = configuring;
    }
    return self;
}

- (NSDictionary *)headersForRequest:(BBCMediaSelectorRequest *)request
{
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    if (request.samlToken) {
        NSAssert([_configuring secureClientId], @"Configuring must return secureClientId when sending requests with SAML tokens");
        [headers setValue:[NSString stringWithFormat:@"%@ x=%@",[_configuring secureClientId],request.samlToken] forKey:@"Authorization"];
    }
    return [NSDictionary dictionaryWithDictionary:headers];
}

@end
