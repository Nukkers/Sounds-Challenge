//
//  BBCHTTPMultiTokenUserAgent.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 23/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPUserAgent.h"
#import "BBCHTTPUserAgentToken.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCHTTPUserAgentTokenSanitizer;

NS_SWIFT_NAME(MultiTokenUserAgent)
@interface BBCHTTPMultiTokenUserAgent : NSObject <BBCHTTPUserAgent>
HTTP_CLIENT_INIT_UNAVAILABLE

- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken*>*)tokens;
- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken*>*)tokens tokenSanitizer:(id<BBCHTTPUserAgentTokenSanitizer>)tokenSanitizer;
- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken *> *)tokens applicationName:(NSString*)applicationName applicationVersion:(NSString*) applicationVersion;
- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken *> *)tokens tokenSanitizer:(id<BBCHTTPUserAgentTokenSanitizer>)tokenSanitizer applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
