//
//  BBCMediaSelectorURLBuilder.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaSelectorRequest.h"
#import "BBCMediaSelectorConfiguring.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaSelectorURLBuilder)
@interface BBCMediaSelectorURLBuilder : NSObject
MEDIA_SELECTOR_INIT_UNAVAILABLE

- (instancetype)initWithConfiguring:(id<BBCMediaSelectorConfiguring>)configuring NS_DESIGNATED_INITIALIZER;
- (NSString *)urlForRequest:(nullable BBCMediaSelectorRequest *)request;

@end

NS_ASSUME_NONNULL_END
