//
//  BBCMediaConnectionFilteringPredicateBuilder.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 28/09/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

@import Foundation;
#import "BBCMediaConnectionFilter.h"
#import "BBCMediaSelectorSecureConnectionPreference.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaConnectionFilteringPredicateBuilder)
@interface BBCMediaConnectionFilteringPredicateBuilder : NSObject

+ (NSPredicate*)predicateForConnectionFilter:(BBCMediaConnectionFilter*)connectionFilter
              withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference;

@end

NS_ASSUME_NONNULL_END
