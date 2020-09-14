//
//  BBCMediaItem.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;
#import "BBCMediaConnection.h"
#import "BBCMediaConnectionSorting.h"
#import "BBCMediaConnectionFilter.h"
#import "BBCMediaSelectorSecureConnectionPreference.h"
#import "MediaSelectorDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaItem)
@interface BBCMediaItem : NSObject
MEDIA_SELECTOR_INIT_UNAVAILABLE

@property (nonatomic, readonly, nullable) NSString* kind;
@property (nonatomic, readonly, nullable) NSString* type;
@property (nonatomic, readonly, nullable) NSString* encoding;
@property (nonatomic, readonly, nullable) NSNumber* bitrate;
@property (nonatomic, readonly, nullable) NSNumber* width;
@property (nonatomic, readonly, nullable) NSNumber* height;
@property (nonatomic, readonly, nullable) NSString* service;
@property (nonatomic, readonly) NSArray<BBCMediaConnection*>* connections;
@property (nonatomic, readonly, nullable) NSDate* expires;
@property (nonatomic, readonly, nullable) NSNumber* mediaFileSize;

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
                 connectionSorting:(nullable id<BBCMediaConnectionSorting>)connectionSorting
                   numberFormatter:(NSNumberFormatter*)numberFormatter
                     dateFormatter:(NSDateFormatter*)dateFormatter NS_DESIGNATED_INITIALIZER;

- (void)setConnectionFilter:(BBCMediaConnectionFilter*)connectionFilter;
- (void)setSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference;

@end

NS_ASSUME_NONNULL_END
