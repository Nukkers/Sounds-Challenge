//
//  BBCSMPAVSeekableTimeRangesObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVSeekableTimeRangesObserver.h"
#import "BBCSMPAVSeekableRangeCache.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"

static const NSString* AVPlayerItemSeekableRangesContext = @"AVPlayerItemSeekableRangesContext";

@implementation BBCSMPAVSeekableTimeRangesObserver {
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
                                                               keyPath:NSStringFromSelector(@selector(seekableTimeRanges))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerItemSeekableRangesContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handleSeekableRangesUpdate)];
    }

    return self;
}

#pragma mark Observation Callback

- (void)handleSeekableRangesUpdate
{
    [_cache update];
}

@end
