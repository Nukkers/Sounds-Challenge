//
//  BBCSMPAVObservationContext.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class AVPlayerItem;
@protocol AVPlayerProtocol;
@protocol BBCSMPDecoderDelegate;
@protocol BBCSMPWorker;

@interface BBCSMPAVObservationContext : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, weak, readonly) id<AVPlayerProtocol> player;
@property (nonatomic, weak, readonly) AVPlayerItem *playerItem;
@property (nonatomic, weak) id<BBCSMPDecoderDelegate> decoderDelegate;
@property (nonatomic, weak, readonly) id<BBCSMPWorker> callbackWorker;

- (instancetype)initWithPlayer:(id<AVPlayerProtocol>)player
                    playerItem:(AVPlayerItem *)playerItem
               decoderDelegate:(id<BBCSMPDecoderDelegate>)delegate
                callbackWorker:(id<BBCSMPWorker>)callbackWorker NS_DESIGNATED_INITIALIZER;

- (void)notifyDelegateUsingBlock:(void (^)(id<BBCSMPDecoderDelegate>))block;

@end

NS_ASSUME_NONNULL_END
