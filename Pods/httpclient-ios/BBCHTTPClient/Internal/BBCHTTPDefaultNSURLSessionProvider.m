//
//  BBCHTTPDefaultNSURLSessionProvider.m
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPDefaultNSURLSessionProvider.h"

@implementation BBCHTTPDefaultNSURLSessionProvider

- (NSURLSession *)prepareSessionWithSessionDelegate:(id<NSURLSessionDelegate>)sessionDelegate
{
    return [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration
                                         delegate:sessionDelegate
                                    delegateQueue:nil];
}

@end
