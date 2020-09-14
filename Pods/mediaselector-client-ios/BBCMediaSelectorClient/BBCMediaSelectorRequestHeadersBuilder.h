//
//  BBCMediaSelectorRequestHeadersBuilder.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 27/07/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaSelectorRequest.h"
#import "BBCMediaSelectorConfiguring.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaSelectorRequestHeadersBuilder)
@interface BBCMediaSelectorRequestHeadersBuilder : NSObject
MEDIA_SELECTOR_INIT_UNAVAILABLE

- (instancetype)initWithConfiguring:(id<BBCMediaSelectorConfiguring>)configuring NS_DESIGNATED_INITIALIZER;
- (NSDictionary<NSString *, id> *)headersForRequest:(BBCMediaSelectorRequest *)request;

@end

NS_ASSUME_NONNULL_END
