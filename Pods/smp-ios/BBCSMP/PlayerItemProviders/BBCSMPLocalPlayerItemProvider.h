//
//  BBCSMPLocalPlayerItemProvider.h
//  SMP
//
//  Created by Stuart Thomas on 15/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPAVType.h"
#import "BBCSMPItemProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPLocalPlayerItemProvider : NSObject <BBCSMPItemProvider>
@property (nonatomic, assign) BBCSMPAVType avType;
@property (nonatomic, copy, nullable) NSString* title;
@property (nonatomic, copy, nullable) NSString* subtitle;
@property (nonatomic, strong, nullable) BBCSMPDuration* duration;
@property (nonatomic, strong, nullable) id<BBCSMPArtworkURLProvider> artworkURLProvider;
@property (nonatomic, assign) NSTimeInterval playOffset;
@property (nonatomic, copy, nullable) NSDictionary <NSString*, NSString*>* customAvStatsLabels;

- (instancetype)initWithURL:(NSURL*)URL andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer;
- (instancetype)initWithURL:(NSURL*)URL andSubtitleURL:(NSURL*)subtitleURL andAVStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer; //TODO TEST THIS

@end

NS_ASSUME_NONNULL_END
