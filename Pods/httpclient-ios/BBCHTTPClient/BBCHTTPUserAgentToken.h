//
//  BBCHTTPUserAgentToken.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 23/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

@import Foundation;
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(UserAgentToken)
@interface BBCHTTPUserAgentToken : NSObject
HTTP_CLIENT_INIT_UNAVAILABLE

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *version;

+ (instancetype)tokenWithName:(NSString *)name version:(NSString *)version;
- (instancetype)initWithName:(NSString *)name version:(NSString *)version NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
