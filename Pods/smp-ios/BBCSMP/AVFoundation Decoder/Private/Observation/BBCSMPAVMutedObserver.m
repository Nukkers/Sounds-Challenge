//
//  BBCSMPAVDecoderMutedObserver.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVMutedObserver.h"
#import "BBCSMPAVObservationContext.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPKVOReceptionist.h"

static const NSString* AVPlayerMutedContext = @"AVPlayerMutedContext";

@implementation BBCSMPAVMutedObserver {
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
                                                               keyPath:NSStringFromSelector(@selector(isMuted))
                                                               options:NSKeyValueObservingOptionNew
                                                               context:&AVPlayerMutedContext
                                                        callbackWorker:context.callbackWorker
                                                                target:self
                                                              selector:@selector(handlePlayerMutedUpdate)];
    }

    return self;
}

#pragma mark Observation Callback

- (void)handlePlayerMutedUpdate
{
    [_context.decoderDelegate decoderMuted:_context.player.muted];
}

@end
