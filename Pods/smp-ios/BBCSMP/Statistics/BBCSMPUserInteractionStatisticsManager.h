//
//  BBCSMPUserInteractionStatisticsManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPPictureInPictureControllerObserver.h"
#import "BBCSMPUserInteractionObserver.h"

@protocol BBCSMPUserInteractionStatisticsConsumer;

@interface BBCSMPUserInteractionStatisticsManager : NSObject <BBCSMPUserInteractionObserver, BBCSMPPictureInPictureControllerObserver>

@property (nonatomic, strong) NSString* counterName;

- (instancetype)initWithCounterName:(NSString*)counterName;

- (void)addStatisticsConsumer:(id<BBCSMPUserInteractionStatisticsConsumer>)consumer;
- (void)removeStatisticsConsumer:(id<BBCSMPUserInteractionStatisticsConsumer>)consumer;

- (void)sendPageViewEvent;

@end
