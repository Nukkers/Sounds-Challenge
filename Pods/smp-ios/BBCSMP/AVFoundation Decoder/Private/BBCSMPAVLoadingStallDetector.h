//
//  BBCSMPAVLoadingStallDetector.h
//  BBCSMPTests
//
//  Created by Richard Gilpin on 09/11/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;
@protocol BBCSMPTimerFactoryProtocol;

@interface BBCSMPAVLoadingStallDetector : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                    timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
     bufferingIntervalUntilStall:(NSTimeInterval)bufferingIntervalUntilStall NS_DESIGNATED_INITIALIZER;
- (void)pause;

@end

NS_ASSUME_NONNULL_END
