//
//  BBCSMPAVDecoderFactory+Internal.h
//  BBCSMP
//
//  Created by Richard Gilpin on 16/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVDecoderFactory.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPAVPlayerItemFactory;

@interface BBCSMPAVDecoderFactory (Internal)

- (instancetype)withTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory;
- (instancetype)withPlayerItemFactory:(id<BBCSMPAVPlayerItemFactory>)playerItemFactory;
- (instancetype)withSeekTolerance:(NSTimeInterval)seekTolerance;
- (instancetype)withSeekCompleteTimeout:(NSTimeInterval)seekCompleteTimeout;

@end

NS_ASSUME_NONNULL_END
