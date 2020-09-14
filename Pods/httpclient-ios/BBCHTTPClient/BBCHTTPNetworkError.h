//
//  BBCHTTPNetworkError.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPError.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const BBCHTTPNetworkClientErrorDomain NS_SWIFT_NAME(NetworkClientErrorDomain);

NS_SWIFT_NAME(NetworkError)
@interface BBCHTTPNetworkError : NSObject <BBCHTTPError>
HTTP_CLIENT_INIT_UNAVAILABLE

+ (instancetype)networkErrorWithError:(nullable NSError *)error
                         httpResponse:(nullable NSHTTPURLResponse *)httpResponse
                                 body:(nullable id)body;
- (instancetype)initWithError:(nullable NSError *)error
                 httpResponse:(nullable NSHTTPURLResponse *)httpResponse
                         body:(nullable id)body NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
