//
//  BBCHTTPMultiTokenUserAgent.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 23/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <sys/utsname.h>

#import "BBCHTTPDefaultUserAgentTokenSanitizer.h"
#import "BBCHTTPDeviceInformation.h"
#import "BBCHTTPMultiTokenUserAgent.h"

@interface BBCHTTPMultiTokenUserAgent ()

@property (readonly) NSString* systemName;
@property (readonly) NSString* systemVersion;
@property (readonly) NSString* specificModelVersion;

@property (strong, nonatomic) id<BBCHTTPUserAgentTokenSanitizer> tokenSanitizer;
@property (strong, nonatomic) NSString* userAgent;
@property (copy, nonatomic) NSString* applicationName;
@property (copy, nonatomic) NSString* applicationVersion;

@end

#pragma mark -

@implementation BBCHTTPMultiTokenUserAgent

static NSString* const BBCHTTPUserAgentCommentFormat = @" (%@; %@ %@)";
static NSString* const BBCHTTPTokenFormat = @"%@/%@";

- (instancetype)initWithTokens:(NSArray<BBCHTTPUserAgentToken *> *)tokens tokenSanitizer:(id<BBCHTTPUserAgentTokenSanitizer>)tokenSanitizer applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion
{
    if (self = [super init]) {
        _tokenSanitizer = tokenSanitizer;
        _applicationName = applicationName;
        _applicationVersion = applicationVersion;
        
        NSMutableString* userAgentString = [NSMutableString string];
        
        // Append an application token that identifies the application name and version
        [self appendToken:[BBCHTTPUserAgentToken tokenWithName:_applicationName version:_applicationVersion] toString:userAgentString];
        
        // Append the comment that identifies the device model, OS and OS version
        [userAgentString appendFormat:BBCHTTPUserAgentCommentFormat, self.specificModelVersion, self.systemName, self.systemVersion];
        
        // Append all the other tokens
        for (BBCHTTPUserAgentToken* token in tokens) {
            [userAgentString appendString:@" "];
            [self appendToken:token toString:userAgentString];
        }
        
        _userAgent = userAgentString;
    }
    
    return self;
}

- (instancetype)initWithTokens:(NSArray<BBCHTTPUserAgentToken*>*)tokens
{
    return [self initWithTokens:tokens tokenSanitizer:[BBCHTTPDefaultUserAgentTokenSanitizer defaultTokenSanitizer]];
}

- (instancetype)initWithTokens:(NSArray<BBCHTTPUserAgentToken*>*)tokens tokenSanitizer:(id<BBCHTTPUserAgentTokenSanitizer>)tokenSanitizer
{
    NSString* applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!applicationName) {
        applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    
    NSString* applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    return [self initWithTokens:tokens tokenSanitizer:tokenSanitizer applicationName:applicationName applicationVersion:applicationVersion];
}

- (instancetype)initWithTokens:(NSArray<BBCHTTPUserAgentToken *> *)tokens applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion
{
    return [self initWithTokens:tokens tokenSanitizer:[BBCHTTPDefaultUserAgentTokenSanitizer defaultTokenSanitizer] applicationName:applicationName applicationVersion:applicationVersion];
}

- (void)appendToken:(BBCHTTPUserAgentToken*)token toString:(NSMutableString*)string
{
    BBCHTTPUserAgentToken* sanitizedToken = [_tokenSanitizer tokenBySanitizingToken:token];
    [string appendFormat:BBCHTTPTokenFormat, sanitizedToken.name, sanitizedToken.version];
}

- (NSString*)systemName
{
    return [BBCHTTPDeviceInformation deviceSystemName];
}

- (NSString*)systemVersion
{
    return [BBCHTTPDeviceInformation deviceSystemVersion];
}

- (NSString*)specificModelVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return @(systemInfo.machine);
}

- (BOOL)isEqual:(id)object
{
    if (![object conformsToProtocol:@protocol(BBCHTTPUserAgent)]) {
        return NO;
    }

    id<BBCHTTPUserAgent> otherUserAgent = object;
    if (!otherUserAgent.userAgent && _userAgent) {
        return NO;
    }

    return [_userAgent isEqualToString:otherUserAgent.userAgent];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ <userAgent=\"%@\">", super.description, _userAgent];
}

@end
