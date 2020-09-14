//
//  BBCSMPAVDecoder.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 02/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDecoder.h"
#import "BBCSMPDefines.h"
#import <CoreMedia/CMTime.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AVPlayerProtocol;
@protocol BBCSMPWorker;
@protocol BBCSMPAVComponentFactory;
@protocol BBCSMPAVPlayerLayerFactory;
@protocol BBCSMPConnectivity;
@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPAVPlayerItemFactory;
@protocol BBCSMPAudioRouter;

@interface BBCSMPAVDecoder : NSObject <BBCSMPDecoder>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<AVPlayerProtocol>)player
              componentFactory:(id<BBCSMPAVComponentFactory>)componentFactory
                  layerFactory:(id<BBCSMPAVPlayerLayerFactory>)layerFactory
                  connectivity:(nullable id<BBCSMPConnectivity>)connectivity
                callbackWorker:(id<BBCSMPWorker>)callbackWorker
               updateFrequency:(CMTime)updateFrequency
                  timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
   bufferingIntervalUntilStall:(NSTimeInterval) bufferingTimeout
             playerItemFactory:(id<BBCSMPAVPlayerItemFactory>)playerItemFactory
                   audioRouter:(id<BBCSMPAudioRouter>)audioRouter
                 seekTolerance:(NSTimeInterval)seekTolerance
seekCompleteTimeout: (NSTimeInterval)seekCompleteTimeout NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
