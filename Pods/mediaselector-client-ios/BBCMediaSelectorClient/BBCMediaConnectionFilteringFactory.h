//
//  BBCMediaConnectionFilteringFactory.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

@import Foundation;
#import "BBCMediaConnectionFilter.h"
#import "BBCMediaConnectionFiltering.h"
#import "BBCMediaSelectorSecureConnectionPreference.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaConnectionFilteringFactory)
@interface BBCMediaConnectionFilteringFactory : NSObject

+ (id<BBCMediaConnectionFiltering>)filteringForFilter:(BBCMediaConnectionFilter*)filter
                       withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)preference;

@end

NS_ASSUME_NONNULL_END
