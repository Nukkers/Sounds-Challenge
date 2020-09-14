//
//  BBCHTTPLoggingNetworkObserver.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPLogger.h"
#import "BBCHTTPNetworkObserver.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(LoggingNetworkObserver)
@interface BBCHTTPLoggingNetworkObserver : NSObject <BBCHTTPNetworkObserver>
HTTP_CLIENT_INIT_UNAVAILABLE

- (instancetype)initWithLogger:(id<BBCHTTPLogger>)logger NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
