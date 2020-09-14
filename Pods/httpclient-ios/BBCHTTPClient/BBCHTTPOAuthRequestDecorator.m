//
//  BBCHTTPOAuthRequestDecorator.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 27/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPOAuthRequestDecorator.h"

@implementation BBCHTTPOAuthRequestDecorator

static NSString *const BBCHTTPOAuthRequestDecoratorAuthenticationProviderHeaderName = @"X-Authentication-Provider";

static NSString *const BBCHTTPOAuthRequestDecoratorAuthorizationHeaderName = @"Authorization";
static NSString *const BBCHTTPOAuthRequestDecoratorAuthorizationHeaderFormat = @"Bearer %@";

+ (BBCHTTPOAuthRequestDecorator *)OAuthRequestDecorator
{
    return [[self alloc] init];
}

- (NSURLRequest *)decorateRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *authorizationHeader = [NSString stringWithFormat:BBCHTTPOAuthRequestDecoratorAuthorizationHeaderFormat,_accessToken];
    [mutableRequest setValue:authorizationHeader forHTTPHeaderField:BBCHTTPOAuthRequestDecoratorAuthorizationHeaderName];
    [mutableRequest setValue:_authenticationProvider forHTTPHeaderField:BBCHTTPOAuthRequestDecoratorAuthenticationProviderHeaderName];
    return [mutableRequest copy];
}

@end
