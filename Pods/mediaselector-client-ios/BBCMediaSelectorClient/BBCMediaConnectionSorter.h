//
//  BBCMediaConnectionSorter.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 23/01/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//
//  Based on BBCiPMediaSelectorSorter created by Matthew Price - POD Mobile Core Engineering on 01/08/2013.
//  Copyright (c) 2013 BBC. All rights reserved.
//

@import Foundation;
#import "MediaSelectorDefines.h"
#import "BBCMediaSelectorRandomization.h"
#import "BBCMediaConnectionSorting.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaConnectionSorter)
@interface BBCMediaConnectionSorter : NSObject <BBCMediaConnectionSorting>
MEDIA_SELECTOR_INIT_UNAVAILABLE

- (instancetype)initWithRandomization:(id<BBCMediaSelectorRandomization>)randomization NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
