//
//  BBCMediaSelectorConfiguring.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaSelectorRequestParameter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCHTTPUserAgent;

NS_SWIFT_NAME(MediaSelectorConfiguring)
@protocol BBCMediaSelectorConfiguring <NSObject>

@property (nonatomic, readonly) NSString *mediaSelectorBaseURL;

@optional

@property (nonatomic, readonly) NSString *secureMediaSelectorBaseURL;
@property (nonatomic, readonly) NSString *secureClientId;
@property (nonatomic, readonly) NSArray<BBCMediaSelectorRequestParameter *> *defaultParameters;
@property (nonatomic, readonly) id<BBCHTTPUserAgent> userAgent;
@property (nonatomic, readonly) NSString *mediaSet;

@end

NS_ASSUME_NONNULL_END
