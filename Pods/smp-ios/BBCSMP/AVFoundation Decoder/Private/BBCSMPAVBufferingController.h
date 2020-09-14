//
//  BBCSMPBufferStateController.h
//  smp-ios
//
//  Created by Richard Gilpin on 13/10/2017.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;
@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPAVPlayerItemFactory;

@interface BBCSMPAVBufferingController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                    timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
     bufferingIntervalUntilStall:(NSTimeInterval)bufferingIntervalUntilStall NS_DESIGNATED_INITIALIZER;

- (void)pause;
- (void)playbackRequested;

@end

NS_ASSUME_NONNULL_END
