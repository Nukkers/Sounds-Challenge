//
//  BBCHTTPDefaultUserAgent.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPMultiTokenUserAgent.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DefaultUserAgent)
@interface BBCHTTPDefaultUserAgent : BBCHTTPMultiTokenUserAgent

@property (class, readonly) BBCHTTPDefaultUserAgent *defaultUserAgent NS_REFINED_FOR_SWIFT;

+ (instancetype)defaultUserAgentWithApplicationName:(NSString *)applicationName applicationVersion:(NSString *)applicationVersion;

@end

NS_ASSUME_NONNULL_END
