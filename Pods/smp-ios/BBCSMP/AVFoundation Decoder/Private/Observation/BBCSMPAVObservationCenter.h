//
//  BBCSMPAVDecoderObservationCenter.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import <CoreMedia/CMTime.h>

NS_ASSUME_NONNULL_BEGIN

@class AVPlayerLayer;
@class BBCSMPAVSeekableRangeCache;
@class BBCSMPAVSeekController;
@class BBCSMPAVExternalPlaybackAdapter;
@class BBCSMPEventBus;
@protocol AVPlayerProtocol;
@protocol BBCSMPWorker;

@interface BBCSMPAVObservationCenter : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign) BOOL streaming;

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                          player:(id<AVPlayerProtocol>)player
                     playerLayer:(AVPlayerLayer *)playerLayer
                 updateFrequency:(CMTime)updateFrequency
         externalPlaybackAdapter:(BBCSMPAVExternalPlaybackAdapter *)externalPlaybackAdapter
              seekableRangeCache:(BBCSMPAVSeekableRangeCache *)seekableRangeCache
                  callbackWorker:(id<BBCSMPWorker>)callbackWorker NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
