//
//  BBCHTTPNetworkURLRequestBuilder.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 29/09/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

@import Foundation;
#import "BBCHTTPURLRequestBuilder.h"
#import "BBCHTTPUserAgent.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkURLRequestBuilder)
@interface BBCHTTPNetworkURLRequestBuilder : NSObject <BBCHTTPURLRequestBuilder>

@property (strong, nonatomic) id<BBCHTTPUserAgent> userAgent;
@property (strong, nonatomic) NSArray<id<BBCHTTPRequestDecorator>> *requestDecorators;

@end

NS_ASSUME_NONNULL_END
