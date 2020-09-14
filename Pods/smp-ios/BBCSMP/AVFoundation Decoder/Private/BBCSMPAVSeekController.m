//
//  BBCSMPAVPlayerSeekController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "AVPlayerProtocol.h"
#import "BBCSMPAVSeekController.h"
#import "BBCSMPDecoder.h"
#import "BBCSMPAVDecoder.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPDuration.h"
#import "BBCSMPTime.h"
#import "BBCSMPAVSeekableRangeCache.h"
#import "BBCSMPTimeRange.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPAVBufferingEvent.h"
#import "BBCSMPAVSeekRequestedEvent.h"
#import "BBCSMPAVItemStatusChangedEvent.h"
#import "BBCSMPAVPrerollCompleteEvent.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVSeekController {
    __weak BBCSMPAVDecoder* _decoder;
    BBCSMPEventBus *_eventBus;
    __weak id<AVPlayerProtocol> _player;
    BBCSMPAVSeekableRangeCache *_seekableRangeCache;
    AVPlayerItem * _Nullable _playerItem;
    BBCSMPTime* _targetSeekTime;
    __weak id<BBCSMPDecoderDelegate> _delegate;
    
    BBCSMPTimeRange* _cachedSeekableTimeRange;
    BBCSMPAVPlayheadMovedController* _playheadChangedController;
    
    BOOL _prerolled;
    dispatch_block_t _pendingSeek;
    NSInteger _seekPendingCount;
}

#pragma mark Initialization

- (instancetype)initWithDecoder:(BBCSMPAVDecoder *)decoder
                       eventBus:(BBCSMPEventBus *)eventBus
                         player:(id<AVPlayerProtocol>)player
             seekableRangeCache:(BBCSMPAVSeekableRangeCache *)seekableRangeCache
        playheadChangedController: (BBCSMPAVPlayheadMovedController *) playheadChangedController
{
    self = [super init];
    if (self) {
        _decoder = decoder;
        _actualSeekTime = kCMTimeZero;
        _eventBus = eventBus;
        _player = player;
        _seekableRangeCache = seekableRangeCache;
        _playheadChangedController = playheadChangedController;

        [_eventBus addTarget:self selector:@selector(playerDidPreroll:) forEventType:[BBCSMPAVPrerollCompleteEvent class]];
        [_eventBus addTarget:self selector:@selector(playerItemDidChange:) forEventType:[BBCSMPAVPlayerItemChangedEvent class]];
        [_eventBus addTarget:self selector:@selector(decoderDelegateDidChange:) forEventType:[BBCSMPAVDecoderDelegateDidChangeEvent class]];
    }
    
    return self;
}

- (BBCSMPTimeRange*)seekableTimeRange;
{
    if (_targetSeekTime != nil) {
        return _cachedSeekableTimeRange;
    }
    else {
        return _seekableRangeCache.seekableTimeRange;
    }
}

#pragma mark Prepare To Play

- (void)prepareToPlay
{
    [_seekableRangeCache update];
    [self scrubToEndOfSeekableRangeIfAttemptingToPlayBeforeSeekableStart];
}

- (void)scrubToEndOfSeekableRangeIfAttemptingToPlayBeforeSeekableStart
{
    if ([self isPlayingOnDemand]) {
        return;
    }
    
    BBCSMPTimeRange* seekableRange = [_decoder seekableRange];
    if ([self pendingSeekToBeforeLiveWindowInProgress:seekableRange.start] || [self playheadIsBeforeLiveWindow:seekableRange.start]) {
        [self scrubToAbsoluteTimeInterval:seekableRange.end];
        [_eventBus sendEvent:[BBCSMPAVBufferingEvent eventWithBuffering:YES]];
    }
}

#pragma mark Scrubbing

-(BOOL)pendingSeekToBeforeLiveWindowInProgress:(NSTimeInterval) startOfSeekableRange {
    return _targetSeekTime != nil && _targetSeekTime.seconds < startOfSeekableRange;
}

-(BOOL)playheadIsBeforeLiveWindow:(NSTimeInterval) startOfSeekableRange {
    double playheadAbsoluteTime = [_playerItem.currentDate timeIntervalSince1970];
    return playheadAbsoluteTime < startOfSeekableRange;
}

- (void)scrubToAbsoluteTimeInterval:(NSTimeInterval)absoluteTimeInterval
{
    if (![self seekTimeHasChanged:absoluteTimeInterval]) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    __weak BBCSMPAVPlayheadMovedController *weakPlayheadChangedController = _playheadChangedController;
    dispatch_block_t seek = ^{
        weakPlayheadChangedController.pendingSeekTargetTime = [weakSelf calculateActualSeekTime:absoluteTimeInterval];
        
        [weakSelf executeSeekActionToTargetTime:absoluteTimeInterval];
    };
    
    if ([self isPlayerReadyForSeekCommands]) {
        seek();
    }
    else {
        _pendingSeek = seek;
    }
}

- (BOOL)seekTimeHasChanged:(NSTimeInterval)absoluteTimeInterval
{
    return _targetSeekTime == nil ? YES : !(_targetSeekTime.seconds == absoluteTimeInterval);
}

- (BOOL)isPlayerReadyForSeekCommands
{
    return _playerItem.status == AVPlayerItemStatusReadyToPlay && _prerolled;
}

- (void)executeSeekActionToTargetTime:(NSTimeInterval)absoluteTimeInterval
{
    if (_cachedSeekableTimeRange == nil) {
        _cachedSeekableTimeRange = _seekableRangeCache.seekableTimeRange;
    }
    
    _targetSeekTime = [self isPlayingOnDemand] ? [BBCSMPTime relativeTime:absoluteTimeInterval] : [BBCSMPTime absoluteTimeWithIntervalSince1970:absoluteTimeInterval];
    _actualSeekTime = [self calculateActualSeekTime:absoluteTimeInterval];
    
    if ([self isScrubbingToEndTime:absoluteTimeInterval]) {
        [self handleScrubbingToTrackEndTimeWhereFrameworkForgetsToTellUsTheContentFinished];
    } else {
        [self performSeek];
    }
}

- (BOOL)isPlayingOnDemand
{
    return !CMTIME_IS_INDEFINITE(_playerItem.duration) ;
}

- (CMTime)calculateActualSeekTime:(NSTimeInterval)absoluteTimeInterval
{
    if ([self isPlayingOnDemand]) {
        return CMTimeMake(absoluteTimeInterval, 1);
    }
    else {
        BBCSMPTimeRange* seekableRange = [self seekableTimeRange];
        return CMTimeMake(absoluteTimeInterval - seekableRange.start + seekableRange.rangeStartOffset, 1);
    }
}

- (BOOL)isScrubbingToEndTime:(NSTimeInterval)absoluteTimeInterval
{
    BBCSMPDuration* duration = [_decoder duration];
    
    // If the duration is 0 we assume that the decoder is not yet ready and the item not fully loaded so we won't be seeking to the end
    BOOL isSeekToEnd = absoluteTimeInterval >= duration.seconds && duration.seconds > 0;
    
    return [self isPlayingOnDemand] && isSeekToEnd;
}

- (void)handleScrubbingToTrackEndTimeWhereFrameworkForgetsToTellUsTheContentFinished
{
    [_player pause];
    [_player seekToTime:_actualSeekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [_delegate decoderPlaying];
    [_delegate decoderFinished];
}

- (void)performSeek
{
    __weak typeof(self) weakSelf = self;
    __weak BBCSMPAVPlayheadMovedController *playheadMovedController = _playheadChangedController;

    void (^completion)(BOOL) = ^(BOOL finished) {
        if (!finished) {
            [playheadMovedController cancelPendingSeek];
        }
        [weakSelf seekToTime:weakSelf.actualSeekTime finishedWithResult:finished];
    };
    
    _seekPendingCount++;
    [_player seekToTime:weakSelf.actualSeekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:completion];
    [_eventBus sendEvent:[BBCSMPAVSeekRequestedEvent event]];
}

- (void)seekToTime:(CMTime)targetTime finishedWithResult:(BOOL)seekOperationCompleted
{
    _seekPendingCount--;
    
    if(seekOperationCompleted) {
        [self handleSeekComplete:targetTime];
    } else if (_seekPendingCount == 0){
        [self resetFlags];
    }
}

- (void)handleSeekComplete:(CMTime)seekedToTime
{
    if ([self allSeeksFinished:seekedToTime]) {
        [self handleAllSeeksFinishedSuccessfully];
    }
}

- (BOOL)allSeeksFinished:(CMTime)seekedToTime
{
    return (CMTIME_COMPARE_INLINE(seekedToTime, ==, _actualSeekTime));
}

- (void)handleAllSeeksFinishedSuccessfully
{
    [_seekableRangeCache update];
    [self resetFlags];
}

- (void)resetFlags
{
    _targetSeekTime = nil;
    _cachedSeekableTimeRange = nil;
}

#pragma mark Domain Event Handlers

- (void)playerDidPreroll:(BBCSMPAVPrerollCompleteEvent *)event
{
    _prerolled = YES;
    [self firePendingSeek];
}

- (void)firePendingSeek {
    if (_pendingSeek) {
        _pendingSeek();
        _pendingSeek = nil;
    }
}

- (void)playerItemDidChange:(BBCSMPAVPlayerItemChangedEvent *)event
{
    _playerItem = event.playerItem;
}

- (void)decoderDelegateDidChange:(BBCSMPAVDecoderDelegateDidChangeEvent *)event
{
    _delegate = [event decoderDelegate];
}

@end
