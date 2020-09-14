//
//  BBCHTTPNSURLSessionProviding.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/10/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

@protocol BBCHTTPNSURLSessionProviding <NSObject>
@required

- (NSURLSession *)prepareSessionWithSessionDelegate:(id<NSURLSessionDelegate>)sessionDelegate;

@end
