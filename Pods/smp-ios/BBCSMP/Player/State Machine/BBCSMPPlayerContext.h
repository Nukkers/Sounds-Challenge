//
//  BBCSMPPlayerContext.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "BBCSMPDefines.h"

@class BBCSMPError;
@class BBCSMPEventBus;
@class BBCSMPItemPreloadMetadata;
@class BBCSMPPlayer;
@class BBCSMPPlayerInitialisationContext;
@class BBCSMPState;
@class BBCSMPSize;
@class BBCSMPTime;
@class BBCSMPTimeRange;
@protocol BBCSMPDecoder;
@protocol BBCSMPAutorecoveryRule;
@protocol BBCSMPItemRetryRule;
@protocol BBCSMPObserver;
@protocol BBCSMPVolumeProvider;

@interface BBCSMPPlayerContext : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong) id<BBCSMPItemRetryRule> itemRetryRule;
@property (nonatomic, strong) BBCSMPSize* playerSize;
@property (nonatomic, strong) BBCSMPTime* time;
@property (nonatomic, assign) CGRect videoRect;
@property (nonatomic, strong) id<BBCSMPDecoder> decoder;
@property (nonatomic, strong) BBCSMPEventBus *eventBus;
@property (assign) BOOL itemProviderChangedSinceLastPlay;
@property (nonatomic, strong) BBCSMPError *decoderError;
@property (nonatomic, strong) id<BBCSMPAutorecoveryRule> autorecoveryRule;
@property (nonatomic, strong) BBCSMPTimeRange* seekableRange;
@property (nonatomic, strong) BBCSMPItemPreloadMetadata* preloadMetadata;
@property (nonatomic, assign) BOOL isMuted;
@property (nonatomic, assign) float volume;
@property (nonatomic, strong) id<BBCSMPVolumeProvider> volumeProvider;
@property (nonatomic, strong) BBCSMPPlayerInitialisationContext* context;

- (instancetype)initWithPlayer:(BBCSMPPlayer *)player context:(BBCSMPPlayerInitialisationContext *)context NS_DESIGNATED_INITIALIZER;

- (void)addObserver:(id<BBCSMPObserver>)observer;
- (void)removeObserver:(id<BBCSMPObserver>)observer;
- (void)notifyObserversForProtocol:(Protocol*)proto withBlock:(void (^)(id observer))block;

@end
