//
//  BBCSMPAVObservationContext.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVObservationContext.h"
#import "BBCSMPWorker.h"

@implementation BBCSMPAVObservationContext

#pragma mark Initialization

- (instancetype)initWithPlayer:(id<AVPlayerProtocol>)player
                    playerItem:(AVPlayerItem *)playerItem
               decoderDelegate:(id<BBCSMPDecoderDelegate>)delegate
                callbackWorker:(id<BBCSMPWorker>)callbackWorker
{
    self = [super init];
    if (self) {
        _player = player;
        _playerItem = playerItem;
        _decoderDelegate = delegate;
        _callbackWorker = callbackWorker;
    }

    return self;
}

#pragma mark Public

- (void)notifyDelegateUsingBlock:(void (^)(id<BBCSMPDecoderDelegate>))block
{
    id<BBCSMPDecoderDelegate> delegate = _decoderDelegate;
    [_callbackWorker performWork:^{
        block(delegate);
    }];
}

@end
