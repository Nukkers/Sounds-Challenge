//
//  BBCSMPStaticURLPlayerItemProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 17/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAVType.h"
#import "BBCSMPItemProvider.h"
#import "BBCSMPStreamType.h"

@protocol BBCSMPArtworkURLProvider;
@class BBCSMPDuration;

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPStaticURLPlayerItemProvider : NSObject <BBCSMPItemProvider>

@property (nonatomic, strong, nullable) NSString* title;
@property (nonatomic, strong, nullable) NSString* subtitle;
@property (nonatomic, strong, nullable) id<BBCSMPArtworkURLProvider> artworkURLProvider;
@property (nonatomic, assign) BBCSMPStreamType streamType;
@property (nonatomic, assign) BBCSMPAVType avType;
@property (nonatomic, strong, nullable) BBCSMPDuration* duration;
@property (nonatomic, assign) NSTimeInterval playOffset;
@property (nonatomic, strong) NSString* versionId;

- (instancetype)initWithURL:(NSURL*)URL avStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer;
- (instancetype)initWithURL:(NSURL*)URL andSubtitleURL:(NSURL*)subtitleURL andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer NS_SWIFT_NAME(init(url:subtitleUrl:avStatisticsConsumer:));
- (instancetype)initWithURL:(NSURL*)URL andSubtitleURL:(NSURL*)subtitleURL andVersionId:(NSString*)versionId andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer NS_SWIFT_NAME(init(url:subtitleUrl:versionId:avStatisticsConsumer:));

@end

NS_ASSUME_NONNULL_END
