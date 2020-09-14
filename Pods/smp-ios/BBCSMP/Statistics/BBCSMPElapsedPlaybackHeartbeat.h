//
//  BBCSMPElapsedPlaybackHeartbeat.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAVStatisticsHeartbeatGenerator.h"
#import <Foundation/Foundation.h>
#import <SMP/SMP-Swift.h>

@interface BBCSMPElapsedPlaybackHeartbeat : NSObject <BBCSMPAVStatisticsHeartbeatGenerator>
@property (nonatomic, weak) id<BBCSMPAVStatisticsHeartbeatGeneratorDelegate> _Nullable delegate;

- (instancetype _Nonnull)initWithDateProvider:(id<BBCSMPDateProvider> _Nonnull)dateProvider NS_DESIGNATED_INITIALIZER;

@end
