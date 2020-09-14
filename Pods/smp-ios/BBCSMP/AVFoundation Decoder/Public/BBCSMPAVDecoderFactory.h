//
//  BBCSMPAVDecoderFactory.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 07/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDecoderFactory.h"
#import <CoreMedia/CMTime.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAVComponentFactory;
@protocol BBCSMPAVPlayerLayerFactory;
@protocol BBCSMPConnectivity;
@protocol BBCSMPWorker;
@protocol BBCSMPAudioRouter;

@interface BBCSMPAVDecoderFactory : NSObject <BBCSMPDecoderFactory>

@property (nonatomic, strong) id<BBCSMPConnectivity> connectivity;
@property (nonatomic, strong) id<BBCSMPWorker> callbackWorker;
@property (nonatomic, assign) NSTimeInterval permittedBufferingIntervalUntilStall;
@property (nonatomic, strong) id<BBCSMPAudioRouter> audioRouter;

- (instancetype)initWithUpdateFrequency:(CMTime)updateFrequency;

- (instancetype)initWithPlayerFactory:(id<BBCSMPAVComponentFactory>)playerFactory
                         layerFactory:(id<BBCSMPAVPlayerLayerFactory>)layerFactory;

- (instancetype)initWithPlayerFactory:(id<BBCSMPAVComponentFactory>)playerFactory
                         layerFactory:(id<BBCSMPAVPlayerLayerFactory>)layerFactory
                      updateFrequency:(CMTime)updateFrequency NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
