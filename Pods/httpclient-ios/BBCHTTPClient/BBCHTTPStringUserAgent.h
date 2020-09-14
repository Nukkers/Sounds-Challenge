//
//  BBCHTTPStringUserAgent.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPUserAgent.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(StringUserAgent)
@interface BBCHTTPStringUserAgent : NSObject <BBCHTTPUserAgent>
HTTP_CLIENT_INIT_UNAVAILABLE

+ (instancetype)userAgentWithString:(NSString *)userAgentString;
- (instancetype)initWithString:(NSString *)userAgentString NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
