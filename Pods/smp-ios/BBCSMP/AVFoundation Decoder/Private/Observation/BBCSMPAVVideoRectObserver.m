//
//  BBCSMPAVVideoRectObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVVideoRectObserver.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"
#import <AVFoundation/AVPlayerLayer.h>

static const NSString* AVPlayerLayerVideoRectContext = @"AVPlayerLayerVideoRectContext";

@implementation BBCSMPAVVideoRectObserver {
    BBCSMPAVObservationContext* _context;
    AVPlayerLayer* _layer;
    BBCSMPKVOReceptionist* _receptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                              decoderLayer:(AVPlayerLayer*)layer
{
    self = [super init];
    if (self) {
        _context = context;
        _layer = layer;
        _receptionist = [BBCSMPKVOReceptionist receptionistWithSubject:layer
                                                               keyPath:NSStringFromSelector(@selector(videoRect))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerLayerVideoRectContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handleVideoRectUpdate)];
    }

    return self;
}

#pragma mark Observation Callback

- (void)handleVideoRectUpdate
{
    [_context.decoderDelegate decoderVideoRectChanged:_layer.videoRect];
}

@end
