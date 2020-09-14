//
//  BBCHTTPLibraryUserAgent.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPMultiTokenUserAgent.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(LibraryUserAgent)
@interface BBCHTTPLibraryUserAgent : BBCHTTPMultiTokenUserAgent

+ (instancetype)userAgentWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion;
+ (instancetype)userAgentWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion;
- (instancetype)initWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithLibraryName:(NSString *)libraryName libraryVersion:(NSString *)libraryVersion applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion NS_DESIGNATED_INITIALIZER;


#pragma mark Unavailable

- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken *> *)tokens NS_UNAVAILABLE;
- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken *> *)tokens tokenSanitizer:(id<BBCHTTPUserAgentTokenSanitizer>)tokenSanitizer NS_UNAVAILABLE;
- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken *> *)tokens applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion NS_UNAVAILABLE;
- (instancetype)initWithTokens:(nullable NSArray<BBCHTTPUserAgentToken *> *)tokens tokenSanitizer:(id<BBCHTTPUserAgentTokenSanitizer>)tokenSanitizer applicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
