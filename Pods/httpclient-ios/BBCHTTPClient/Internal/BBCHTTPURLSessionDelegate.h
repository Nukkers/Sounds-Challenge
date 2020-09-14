//
//  BBCHTTPURLSessionDelegate.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCHTTPNetworkClientContext;

@interface BBCHTTPURLSessionDelegate : NSObject <NSURLSessionDownloadDelegate, NSURLSessionDataDelegate>
HTTP_CLIENT_INIT_UNAVAILABLE

- (instancetype)initWithContext:(BBCHTTPNetworkClientContext *)context NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
