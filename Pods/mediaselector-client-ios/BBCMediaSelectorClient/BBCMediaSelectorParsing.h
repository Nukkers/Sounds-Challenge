//
//  BBCMediaSelectorParsing.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 13/02/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class BBCMediaSelectorResponse;

NS_SWIFT_NAME(MediaSelectorParsing)
@protocol BBCMediaSelectorParsing <NSObject>

- (nullable BBCMediaSelectorResponse *)responseFromJSONObject:(nullable id)jsonObject error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
