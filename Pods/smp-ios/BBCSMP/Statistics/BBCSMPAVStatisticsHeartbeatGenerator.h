//
//  BBCSMPAVStatisticsHeartbeatGenerator.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 06/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPState.h"

@protocol BBCSMPAVStatisticsHeartbeatGeneratorDelegate <NSObject>

- (void)sendAVStatisticsHeartbeatForElapsedPlaybackTime:(NSUInteger)elapsedPlaybackTime;

@end

@protocol BBCSMPAVStatisticsHeartbeatGenerator <NSObject>

- (void)setDelegate:(id<BBCSMPAVStatisticsHeartbeatGeneratorDelegate>)delegate;
- (void)stateChanged:(BBCSMPState*)state;
- (void)update;
- (NSUInteger)elapsedPlaybackTime;

@end
