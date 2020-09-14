//
//  BBCSMPAVDecoderDurationObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVDurationObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVSeekableRangeCache.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"

static const NSString* AVPlayerItemDurationContext = @"AVPlayerItemDurationContext";

@implementation BBCSMPAVDurationObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPAVSeekableRangeCache* _cache;
    BBCSMPKVOReceptionist* _receptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                        seekableRangeCache:(BBCSMPAVSeekableRangeCache*)cache
{
    self = [super init];
    if (self) {
        _context = context;
        _cache = cache;
        _receptionist = [BBCSMPKVOReceptionist receptionistWithSubject:context.playerItem
                                                               keyPath:NSStringFromSelector(@selector(duration))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerItemDurationContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handleDurationUpdate)];
    }

    return self;
}

#pragma mark Observation Callback

- (void)handleDurationUpdate
{
    // There is a bug in iOS 7 where it takes a while for the duration of a player item to propogate through
    // once it has been set, meaning that the seekable ranges don't get set as it thinks we have a duration
    // of 0. This causes the seek bar to not appear, so by listening for this update we can update the ranges
    // and get back on track.
    [_cache update];
}

@end
