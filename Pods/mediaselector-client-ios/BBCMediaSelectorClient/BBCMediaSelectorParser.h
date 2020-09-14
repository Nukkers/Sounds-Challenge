//
//  BBCMediaSelectorParser.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 12/02/2015.
//  Copyright (c) 2015 Michael Emmens. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaSelectorParsing.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCMediaConnectionSorting;

NS_SWIFT_NAME(MediaSelectorParser)
@interface BBCMediaSelectorParser : NSObject <BBCMediaSelectorParsing>
MEDIA_SELECTOR_INIT_UNAVAILABLE

@property (class, nonatomic, strong, readonly) NSNumberFormatter *createNumberFormatter NS_REFINED_FOR_SWIFT;
@property (class, nonatomic, strong, readonly) NSDateFormatter *createDateFormatter NS_REFINED_FOR_SWIFT;

- (instancetype)initWithConnectionSorting:(nullable id<BBCMediaConnectionSorting>)connectionSorting NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
