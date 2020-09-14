//
//  BBCSMPStatisticsManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPErrorObserver.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPNetworkStatusManager.h"
#import "BBCSMPPlayerSizeObserver.h"
#import "BBCSMPStateObserver.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPTimeObserver.h"
#import "BBCSMPNetworkStatusObserver.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPAVStatisticsHeartbeatGenerator.h"

@protocol BBCSMPAVStatisticsConsumer;

@interface BBCSMPAVStatisticsManager : NSObject <BBCSMPItemObserver,
                                                 BBCSMPStateObserver,
                                                 BBCSMPTimeObserver,
                                                 BBCSMPSubtitleObserver,
                                                 BBCSMPErrorObserver,
                                                 BBCSMPPlayerSizeObserver,
                                                 BBCSMPNetworkStatusObserver,
                                                 BBCSMPPreloadMetadataObserver>

- (instancetype)initWithHeartbeatGenerator:(id<BBCSMPAVStatisticsHeartbeatGenerator>)heartbeatGenerator;

@property (nonatomic, weak) id<BBCSMPAVStatisticsConsumer> avStatisticsConsumer;

@end
