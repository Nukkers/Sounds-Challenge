//
//  BBCSMPAVPlayerSeekController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import <AVFoundation/AVFoundation.h>

@class BBCSMPAVSeekableRangeCache;
@class BBCSMPDuration;
@class BBCSMPEventBus;
@class BBCSMPTimeRange;
@class BBCSMPAVPlayheadMovedController;
@protocol BBCSMPDecoderDelegate;
@protocol AVPlayerProtocol;
@protocol BBCSMPDecoder;
@protocol BBCSMPTimerFactoryProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAVSeekController : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, readonly) CMTime actualSeekTime;

- (instancetype)initWithDecoder:(id<BBCSMPDecoder>)decoder
                       eventBus:(BBCSMPEventBus *)eventBus
                         player:(id<AVPlayerProtocol>)player
             seekableRangeCache:(BBCSMPAVSeekableRangeCache *)seekableRangeCache
         playheadChangedController: (BBCSMPAVPlayheadMovedController *) playheadChangedController NS_DESIGNATED_INITIALIZER;

- (void)prepareToPlay;
- (void)scrubToAbsoluteTimeInterval:(NSTimeInterval)absoluteTimeInterval;
- (BBCSMPTimeRange *)seekableTimeRange;

@end

NS_ASSUME_NONNULL_END
