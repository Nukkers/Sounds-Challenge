//
//  BBCHTTPNetworkTask.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 05/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPTask.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkTask)
@interface BBCHTTPNetworkTask : NSObject <BBCHTTPTask>
HTTP_CLIENT_INIT_UNAVAILABLE

+ (instancetype)networkTaskWithSessionTask:(NSURLSessionTask *)sessionTask;
- (instancetype)initWithSessionTask:(NSURLSessionTask *)sessionTask NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
