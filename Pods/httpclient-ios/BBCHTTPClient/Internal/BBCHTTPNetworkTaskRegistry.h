//
//  BBCHTTPNetworkTaskRegistry.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 26/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCHTTPNetworkTask;

@interface BBCHTTPNetworkTaskRegistry : NSObject

@property (readonly) NSUInteger count;

- (void)addTask:(BBCHTTPNetworkTask *)task;
- (void)removeTask:(BBCHTTPNetworkTask *)task;
- (nullable BBCHTTPNetworkTask *)networkTaskForSessionTask:(NSURLSessionTask *)sessionTask;

@end

NS_ASSUME_NONNULL_END
