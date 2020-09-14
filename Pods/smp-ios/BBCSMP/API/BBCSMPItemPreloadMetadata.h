//
//  BBCSMPItemPreloadMetadata.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 17/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPAVType.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPDuration;
@class BBCSMPItemMetadata;
@protocol BBCSMPArtworkFetcher;

@interface BBCSMPItemPreloadMetadata : NSObject

@property (nonatomic, copy, nullable) NSString* title;
@property (nonatomic, copy, nullable) NSString* subtitle;
@property (nonatomic, copy, nullable) NSString* guidanceMessage;
@property (nonatomic, strong) BBCSMPDuration* duration;
@property (nonatomic, strong, readonly) BBCSMPItemMetadata* partialMetadata;
@property (nonatomic, strong, nullable) NSDictionary <NSString*, NSString*>* customAvStatsLabels;

// Providing programme artwork: Implement artworkFetcher to use your own custom
// fetching for programme artwork. To use the standard network fetching behaviour,
// implement artworkURLProvider and leave artworkFetcher unimplemented.
@property (nonatomic, strong, nullable) id<BBCSMPArtworkFetcher> artworkFetcher;

@property (nonatomic, copy) NSString* decoderName;
@property (nonatomic, copy) NSString* decoderVersion;

@end

NS_ASSUME_NONNULL_END
