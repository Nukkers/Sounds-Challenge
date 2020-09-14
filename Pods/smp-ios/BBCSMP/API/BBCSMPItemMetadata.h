//
//  BBCSMPItemMetadata.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAVType.h"
#import "BBCSMPMediaRetrievalType.h"
#import "BBCSMPPIPSType.h"
#import "BBCSMPStreamType.h"
#import "BBCSMPMediaBitrate.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPItemPreloadMetadata;

@interface BBCSMPItemMetadata : NSObject

@property (nonatomic, strong) BBCSMPItemPreloadMetadata* preloadMetadata;
@property (nonatomic, assign) BBCSMPPIPSType pipsType;
@property (nonatomic, assign) BBCSMPAVType avType;
@property (nonatomic, assign) BBCSMPMediaRetrievalType mediaRetrievalType;
@property (nonatomic, assign) BBCSMPStreamType streamType;
@property (nonatomic, strong) NSString* contentId;
@property (nonatomic, strong) NSString* versionId;
@property (nonatomic, strong) NSString* serviceId;
@property (nonatomic, strong) NSString* supplier;
@property (nonatomic, strong) NSString* transferFormat;
@property (nonatomic, assign) BBCSMPMediaBitrate* mediaBitrate;

- (instancetype)initWithPreloadMetadata:(nullable BBCSMPItemPreloadMetadata*)preloadMetadata NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
