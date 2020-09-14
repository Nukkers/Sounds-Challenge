//
//  BBCSMPAVVolumeObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPAVVolumeObserver.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"

static const NSString* AVPlayerVolumeContext = @"AVPlayerVolumeContext";

@implementation BBCSMPAVVolumeObserver {
    BBCSMPAVObservationContext* _context;
    BBCSMPKVOReceptionist* _receptionist;
}

#pragma mark Initialization

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
{
    self = [super init];
    if (self) {
        _context = context;
        _receptionist = [BBCSMPKVOReceptionist receptionistWithSubject:context.player
                                                               keyPath:NSStringFromSelector(@selector(volume))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerVolumeContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handlePlayerVolumeUpdate)];
    }

    return self;
}

#pragma mark Observation Callback

- (void)handlePlayerVolumeUpdate
{
    [_context.decoderDelegate decoderVolumeChanged:_context.player.volume];
}

@end
