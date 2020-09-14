//
//  BBCSMPAVErrorController.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVErrorController.h"
#import "BBCSMPAVCriticalErrorEvent.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPError.h"
#import "BBCSMPAVFailedToLoadPlaylistEvent.h"
#import "BBCSMPAVPlaybackStalledEvent.h"
#import "BBCSMPAVFailedToPlayToEndTimeEvent.h"
#import "BBCSMPAVErrors.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVErrorController {
    BOOL _decoderInFailureState;
    __weak id<BBCSMPDecoderDelegate> _decoderDelegate;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
{
    self = [super init];
    if (self) {
        [eventBus addTarget:self selector:@selector(criticalErrorEventOccurred:) forEventType:[BBCSMPAVCriticalErrorEvent class]];
        [eventBus addTarget:self selector:@selector(failedToLoadPlaylistEventOccurred:) forEventType:[BBCSMPAVFailedToLoadPlaylistEvent class]];
        [eventBus addTarget:self selector:@selector(playbackStalledEventOccurred:) forEventType:[BBCSMPAVPlaybackStalledEvent class]];
        [eventBus addTarget:self selector:@selector(failedToPlayToEndTimeEventOccurred:) forEventType:[BBCSMPAVFailedToPlayToEndTimeEvent class]];
        [eventBus addTarget:self selector:@selector(decoderDelegateDidChange:) forEventType:[BBCSMPAVDecoderDelegateDidChangeEvent class]];
    }
    
    return self;
}

#pragma mark Domain Event Handlers

- (void)criticalErrorEventOccurred:(BBCSMPAVCriticalErrorEvent *)event
{
    if (!_decoderInFailureState) {
        [_decoderDelegate decoderFailed:[[BBCSMPError alloc] initWithError:event.error reason:BBCSMPErrorUnknown recoverable:NO]];
        _decoderInFailureState = YES;
    }
}

- (void)failedToLoadPlaylistEventOccurred:(BBCSMPAVFailedToLoadPlaylistEvent *)event
{
    if (!_decoderInFailureState) {
        NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
        [_decoderDelegate decoderFailed:[[BBCSMPError alloc] initWithError:error reason:BBCSMPErrorUnknown recoverable:YES]];
        _decoderInFailureState = YES;
    }
}

- (void)playbackStalledEventOccurred:(BBCSMPAVPlaybackStalledEvent *)event
{
    if (!_decoderInFailureState) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : @"An unknown error occurred" };
        NSError *error = [NSError errorWithDomain:BBCSMPAVDecoderErrorDomain code:BBCSMPErrorUnknown userInfo:userInfo];
        [_decoderDelegate decoderFailed:[[BBCSMPError alloc] initWithError:error reason:BBCSMPErrorUnknown recoverable:YES]];
        _decoderInFailureState = YES;
    }
}

- (void)failedToPlayToEndTimeEventOccurred:(BBCSMPAVFailedToPlayToEndTimeEvent *)event
{
    if (!_decoderInFailureState) {
        NSDictionary* userInfo = @{ NSLocalizedDescriptionKey : @"Player failed to play to the end of the content." };
        NSError* error = [NSError errorWithDomain:BBCSMPPlayerErrorDomain code:BBCSMPErrorFailedToPlayToEnd userInfo:userInfo];
        [_decoderDelegate decoderFailed:[[BBCSMPError alloc] initWithError:error reason:BBCSMPErrorUnknown recoverable:YES]];
    }
}

- (void)decoderDelegateDidChange:(BBCSMPAVDecoderDelegateDidChangeEvent *)event
{
    _decoderDelegate = [event decoderDelegate];
}

@end
