//
//  BBCHTTPDefaultUserAgent.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPDefaultUserAgent.h"
#import "BBCHTTPVersion.h"

@implementation BBCHTTPDefaultUserAgent

+ (BBCHTTPDefaultUserAgent *)defaultUserAgent
{
    return [[self alloc] initWithTokens:@[[BBCHTTPUserAgentToken tokenWithName:@"BBCHTTPClient" version:@BBC_HTTP_VERSION]]];
}

+ (instancetype)defaultUserAgentWithApplicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion
{
    return [[self alloc] initWithApplicationName:applicationName applicationVersion:applicationVersion];
}

- (instancetype)initWithApplicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion
{
    self = [super initWithTokens:@[[BBCHTTPUserAgentToken tokenWithName:@"BBCHTTPClient" version:@BBC_HTTP_VERSION]] applicationName:applicationName applicationVersion:applicationVersion];
    return self;
}

@end
