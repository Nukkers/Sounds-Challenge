//
//  BBCMediaNoPreferenceConnectionFiltering.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaConnectionFilter.h"
#import "BBCMediaConnectionFiltering.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaNoPreferenceConnectionFiltering)
@interface BBCMediaNoPreferenceConnectionFiltering : NSObject <BBCMediaConnectionFiltering>
MEDIA_SELECTOR_INIT_UNAVAILABLE

- (instancetype)initWithFilter:(BBCMediaConnectionFilter*)filter NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
