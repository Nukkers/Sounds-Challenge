//
//  BBCSMPLocalPlayerItemProviderBuilder.h
//  SMP
//
//  Created by Stuart Thomas on 15/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//
#import "BBCSMPAVType.h"

NS_ASSUME_NONNULL_BEGIN;

@protocol BBCSMPItemProvider;
@class BBCSMPDuration;
@protocol BBCSMPArtworkURLProvider;
@protocol BBCSMPAVStatisticsConsumer;

@interface BBCSMPLocalPlayerItemProviderBuilder : NSObject
@property (nonatomic, assign) BBCSMPAVType avType;
@property (nonatomic, strong, nullable) NSString* title;
@property (nonatomic, strong, nullable) NSString* subtitle;
@property (nonatomic, strong, nullable) BBCSMPDuration* duration;
@property (nonatomic, strong, nullable) id<BBCSMPArtworkURLProvider> artworkURLProvider;
@property (nonatomic, assign) NSTimeInterval playOffset;
@property (nonatomic, strong, nullable) NSDictionary<NSString*, NSString*>* customAvStatsLabels;

- (instancetype)withAVType:(BBCSMPAVType)avType;
- (instancetype)withTitle:(NSString*)title;
- (instancetype)withSubtitle:(NSString*)subtitle;
- (instancetype)withDuration:(BBCSMPDuration*)duration;
- (instancetype)withArtworkURLProvider:(id<BBCSMPArtworkURLProvider>) artworkURLProvider;
- (instancetype)withPlayOffset:(NSTimeInterval)playOffset;
- (instancetype)withCustomAvStatsLabels:(NSDictionary<NSString*, NSString*>*)customAvStatsLabels;

- (id<BBCSMPItemProvider>)buildForURL:(NSURL*)url andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer;
- (id<BBCSMPItemProvider>)buildForURL:(NSURL*)url andSubtitleURL:(NSURL*)subtitleUrl andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer;

@end
NS_ASSUME_NONNULL_END;
