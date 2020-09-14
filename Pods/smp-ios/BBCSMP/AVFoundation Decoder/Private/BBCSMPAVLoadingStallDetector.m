//
//  BBCSMPAVLoadingStallDetector.m
//  BBCSMPTests
//
//  Created by Richard Gilpin on 09/11/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVLoadingStallDetector.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVCriticalErrorEvent.h"
#import "BBCSMPAVItemStatusChangedEvent.h"
#import "BBCSMPAVErrors.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPTimerProtocol.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVLoadingStallDetector {
    BBCSMPEventBus *_eventBus;
    id<BBCSMPTimerFactoryProtocol> _timerFactory;
    id<BBCSMPTimerProtocol> _timer;
    NSTimeInterval _bufferingIntervalUntilStall;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                    timerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
     bufferingIntervalUntilStall:(NSTimeInterval)bufferingIntervalUntilStall
{
    self = [super init];
    if (self) {
        _eventBus = eventBus;
        _timerFactory = timerFactory;
        _bufferingIntervalUntilStall = bufferingIntervalUntilStall;
        
        [eventBus addTarget:self
                   selector:@selector(playerItemDidChange:)
               forEventType:[BBCSMPAVPlayerItemChangedEvent class]];
        [eventBus addTarget:self
                   selector:@selector(playerItemStatusDidChange:)
               forEventType:[BBCSMPAVItemStatusChangedEvent class]];
    }
    
    return self;
}

#pragma mark Domain Event Handlers

- (void)playerItemDidChange:(BBCSMPAVPlayerItemChangedEvent *)event
{
    [self startLoadingStallDetection];
}

- (void)playerItemStatusDidChange:(BBCSMPAVItemStatusChangedEvent *)event
{
    [self stopLoadingStallDetection];
}

#pragma mark Pausing

- (void)pause
{
    [self stopLoadingStallDetection];
}

#pragma mark Stall Detection

- (void)startLoadingStallDetection
{
    _timer = [_timerFactory timerWithInterval:_bufferingIntervalUntilStall
                                       target:self
                                     selector:@selector(loadingStallDetectionPeriodDidElapse)];
}

- (void)loadingStallDetectionPeriodDidElapse
{
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : @"An unknown error occurred" };
    NSError *error = [NSError errorWithDomain:BBCSMPAVDecoderErrorDomain
                                         code:0
                                     userInfo:userInfo];
    BBCSMPAVCriticalErrorEvent *event = [BBCSMPAVCriticalErrorEvent eventWithError:error];
    
    [_eventBus sendEvent:event];
}

- (void)stopLoadingStallDetection
{
    [_timer stop];
}

@end
