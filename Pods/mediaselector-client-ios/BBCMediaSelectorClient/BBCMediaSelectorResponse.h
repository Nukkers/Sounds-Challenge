//
//  BBCMediaSelectorResponse.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "BBCMediaConnectionSorting.h"
#import "BBCMediaItem.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaSelectorResponse)
@interface BBCMediaSelectorResponse : NSObject

- (instancetype)initWithMediaArray:(NSArray<NSDictionary<NSString *, id> *>*)mediaArray
                 connectionSorting:(nullable id<BBCMediaConnectionSorting>)connectionSorting
                   numberFormatter:(NSNumberFormatter*)numberFormatter
                     dateFormatter:(NSDateFormatter*)dateFormatter;

- (void)setSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference;
- (NSArray<NSNumber *> *)availableBitrates;
- (nullable BBCMediaItem*)itemForBitrate:(NSNumber*)bitrate;
- (nullable BBCMediaItem*)itemForHighestBitrate;
- (nullable BBCMediaItem*)itemForCaptions;

@end

NS_ASSUME_NONNULL_END
