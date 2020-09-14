//
//  BBCMediaSelectorRequestParameter.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaSelectorRequestParameter)
@interface BBCMediaSelectorRequestParameter : NSObject
MEDIA_SELECTOR_INIT_UNAVAILABLE

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *value NS_SWIFT_NAME(stringValue);

- (instancetype)initWithName:(NSString *)name value:(NSString *)value NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
