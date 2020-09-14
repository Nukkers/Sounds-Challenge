//
//  BBCHTTPFileLoggingNetworkObserver.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPLoggingNetworkObserver.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(FileLoggingNetworkObserver)
@interface BBCHTTPFileLoggingNetworkObserver : BBCHTTPLoggingNetworkObserver

- (instancetype)initWithLogFilePath:(NSString*)logFilePath NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithLogger:(id<BBCHTTPLogger>)logger NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
