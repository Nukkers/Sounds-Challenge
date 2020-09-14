//
//  BBCSMPBufferStateController.m
//  smp-ios
//
//  Created by Richard Gilpin on 13/10/2017.
//

#import "BBCSMPAVBufferingController.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPError.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPAVErrors.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVBufferingEvent.h"
#import "BBCSMPAVSeekRequestedEvent.h"
#import "BBCSMPAVFailedToLoadPlaylistEvent.h"
#import "AVPlayerProtocol.h"
#import "BBCSMPAVPlayerItemFactory.h"
#import "BBCSMPAVSeekableRangeCache.h"
#import "BBCSMPAVPlaybackStalledEvent.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVBufferingController {
    id<BBCSMPTimerFactoryProtocol> _timerFactory;
    id<BBCSMPTimerProtocol> _stallDetectionTimer;
    NSTimeInterval _permittedBufferingIntervalUntilStallDetected;
    BBCSMPEventBus *_eventBus;
    __weak id<BBCSMPDecoderDelegate> _decoderDelegate;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                    timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
     bufferingIntervalUntilStall:(NSTimeInterval)bufferingIntervalUntilStall
{
    self = [super init];
    if(self) {
        _timerFactory = timerFactory;
        _permittedBufferingIntervalUntilStallDetected = bufferingIntervalUntilStall;
        _eventBus = eventBus;
        
        [_eventBus addTarget:self selector:@selector(bufferingEventOccurred:) forEventType:[BBCSMPAVBufferingEvent class]];
        [_eventBus addTarget:self selector:@selector(decoderDidSeek:) forEventType:[BBCSMPAVSeekRequestedEvent class]];
        [_eventBus addTarget:self selector:@selector(playheadMoved:) forEventType:[BBCSMPAVPlayheadMovedEvent class]];
        [_eventBus addTarget:self selector:@selector(decoderDelegateDidChange:) forEventType:[BBCSMPAVDecoderDelegateDidChangeEvent class]];
    }
    
    return self;
}

#pragma mark Public

- (void)pause
{
    [self stopBufferingStallDetection];
}

- (void)playbackRequested
{
    [self startBufferingStallDetection];
}

#pragma mark Domain Event Handlers

- (void)decoderDidSeek:(__unused BBCSMPAVSeekRequestedEvent *)event
{
    [self stopBufferingStallDetection];
}

- (void)bufferingEventOccurred:(BBCSMPAVBufferingEvent *)event
{
    BOOL buffering = event.isBuffering;
    [_decoderDelegate decoderBuffering:buffering];
    
    if (buffering) {
        [self startBufferingStallDetection];
    }
    else {
        [self stopBufferingStallDetection];
    }
}

- (void)playheadMoved:(__unused BBCSMPAVPlayheadMovedEvent *)event
{
    [self stopBufferingStallDetection];
}

- (void)decoderDelegateDidChange:(BBCSMPAVDecoderDelegateDidChangeEvent *)event
{
    _decoderDelegate = [event decoderDelegate];
}

#pragma mark Buffering Stall Detection

- (void)stopBufferingStallDetection
{
    [_stallDetectionTimer stop];
    _stallDetectionTimer = nil;
}

- (void)startBufferingStallDetection
{
    if (!_stallDetectionTimer) {
        _stallDetectionTimer = [_timerFactory timerWithInterval:_permittedBufferingIntervalUntilStallDetected
                                                         target:self
                                                       selector:@selector(stallDetectionIntervalDidElapse)];
    }
}

- (void)stallDetectionIntervalDidElapse
{
    [self stopBufferingStallDetection];
    [self dispatchPlaybackStalledEvent];
}

- (void)dispatchPlaybackStalledEvent
{
    BBCSMPAVPlaybackStalledEvent *event = [BBCSMPAVPlaybackStalledEvent event];
    [_eventBus sendEvent:event];
}

@end
