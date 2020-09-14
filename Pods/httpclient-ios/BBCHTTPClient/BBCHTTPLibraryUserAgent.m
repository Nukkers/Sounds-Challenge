//
//  BBCHTTPLibraryUserAgent.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPLibraryUserAgent.h"
#import "BBCHTTPVersion.h"
#import "BBCHTTPDefaultUserAgentTokenSanitizer.h"

@implementation BBCHTTPLibraryUserAgent

+ (instancetype)userAgentWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion
{
    return [[self alloc] initWithLibraryName:libraryName libraryVersion:libraryVersion];
}

+ (instancetype)userAgentWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion
{
    return [[self alloc] initWithLibraryName:libraryName libraryVersion:libraryVersion applicationName:applicationName applicationVersion:applicationVersion];
}

- (instancetype)initWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion
{
    NSString* applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!applicationName) {
        applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    
    NSString* applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];

    self = [super initWithTokens:@[[BBCHTTPUserAgentToken tokenWithName:libraryName version:libraryVersion], [BBCHTTPUserAgentToken tokenWithName:@"BBCHTTPClient" version:@BBC_HTTP_VERSION]] tokenSanitizer:[BBCHTTPDefaultUserAgentTokenSanitizer defaultTokenSanitizer] applicationName:applicationName applicationVersion:applicationVersion];
    return self;
}

- (instancetype)initWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion
{
    self = [super initWithTokens:@[[BBCHTTPUserAgentToken tokenWithName:libraryName version:libraryVersion], [BBCHTTPUserAgentToken tokenWithName:@"BBCHTTPClient" version:@BBC_HTTP_VERSION]] tokenSanitizer:[BBCHTTPDefaultUserAgentTokenSanitizer defaultTokenSanitizer] applicationName:applicationName applicationVersion:applicationVersion];
    return self;
}

@end
