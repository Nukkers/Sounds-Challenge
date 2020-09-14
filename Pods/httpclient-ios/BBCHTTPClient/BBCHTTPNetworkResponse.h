//
//  BBCHTTPNetworkResponse.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPResponse.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkResponse)
@interface BBCHTTPNetworkResponse : NSObject <BBCHTTPResponse>
HTTP_CLIENT_INIT_UNAVAILABLE

@property (nonatomic, readonly, strong, nullable) NSHTTPURLResponse * httpResponse;

+ (instancetype)networkResponseWithResponse:(nullable NSHTTPURLResponse *)response body:(nullable id)body;
- (instancetype)initWithResponse:(nullable NSHTTPURLResponse *)response body:(nullable id)body NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
