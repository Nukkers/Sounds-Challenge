//
//  BBCHTTPRequestDecorator.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;

NS_SWIFT_NAME(RequestDecorator)
@protocol BBCHTTPRequestDecorator <NSObject>

- (nonnull NSURLRequest *)decorateRequest:(nonnull NSURLRequest *)request;

@end
