//
//  BBCHTTPSAMLRequestDecorator.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 27/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPSAMLRequestDecorator.h"

@interface BBCHTTPSAMLRequestDecorator ()

@property (copy,nonatomic) NSString *clientName;

@end

#pragma mark -

@implementation BBCHTTPSAMLRequestDecorator

static NSString *const BBCHTTPSAMLRequestDecoratorAuthorizationHeaderName = @"Authorization";
static NSString *const BBCHTTPSAMLRequestDecoratorAuthorizationHeaderFormat = @"%@ x=%@";

+ (BBCHTTPSAMLRequestDecorator *)SAMLRequestDecoratorWithClientName:(NSString *)clientName
{
    return [[self alloc] initWithClientName:clientName];
}

- (instancetype)initWithClientName:(NSString *)clientName
{
    if ((self = [super init])) {
        _samlToken = @"";
        _clientName = clientName;
    }

    return self;
}

- (NSURLRequest *)decorateRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    NSString *authorizationHeader = [NSString stringWithFormat:BBCHTTPSAMLRequestDecoratorAuthorizationHeaderFormat,_clientName,_samlToken];
    [mutableRequest setValue:authorizationHeader forHTTPHeaderField:BBCHTTPSAMLRequestDecoratorAuthorizationHeaderName];
    return [mutableRequest copy];
}

@end
