//
//  BBCHTTPNetworkClient+Internal.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPNetworkClient.h"
#import "BBCHTTPNetworkClientContext.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCHTTPNSURLSessionProviding;

@interface BBCHTTPNetworkClient ()

@property (strong, nonatomic) NSURLSession* urlSession;
@property (strong, nonatomic) BBCHTTPNetworkClientContext *context;

- (instancetype)initWithSessionProviding:(id<BBCHTTPNSURLSessionProviding>)sessionProviding NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
