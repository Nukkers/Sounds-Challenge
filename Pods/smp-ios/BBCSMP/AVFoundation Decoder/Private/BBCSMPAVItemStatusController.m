//
//  BBCSMPAVPlaybackStatusController.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPAVItemStatusController.h"
#import "BBCSMPEventBus.h"
#import "AVPlayerProtocol.h"
#import "BBCSMPAVItemStatusChangedEvent.h"
#import "BBCSMPAVCriticalErrorEvent.h"
#import "BBCSMPDecoderDelegate.h"
#import "BBCSMPAVPrerollCompleteEvent.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVItemStatusController {
    BBCSMPEventBus *_eventBus;
    id<AVPlayerProtocol> _player;
    BOOL _hasBuffered;
    AVPlayerItem *_playerItem;
    BOOL _preRolled;
    __weak id<BBCSMPDecoderDelegate> _decoderDelegate;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                         player:(id<AVPlayerProtocol>)player
{
    self = [super init];
    if(self) {
        _eventBus = eventBus;
        _player = player;
        
        [_eventBus addTarget:self selector:@selector(itemStatusChangedEventOccured:) forEventType:[BBCSMPAVItemStatusChangedEvent class]];
        [_eventBus addTarget:self selector:@selector(itemChangedEventOccured:) forEventType:[BBCSMPAVPlayerItemChangedEvent class]];
    }
    
    return self;
}

#pragma mark Domain Event Handlers

- (void)itemStatusChangedEventOccured:(BBCSMPAVItemStatusChangedEvent *)event
{
    AVPlayerItemStatus status = event.status;
    switch (status) {
        case AVPlayerItemStatusReadyToPlay: {
            
            if (!_preRolled) {
                __weak typeof(_eventBus) weakEventBus = _eventBus;
                [_player prerollAtRate:1.0 completionHandler:^(BOOL finished) {
                    BBCSMPAVPrerollCompleteEvent *event = [BBCSMPAVPrerollCompleteEvent eventWithPrerollCompletionState:finished];
                    [weakEventBus sendEvent:event];
                }];
                _preRolled = YES;
            }
            
            break;
        }
        case AVPlayerItemStatusFailed: {
            [_eventBus sendEvent:[BBCSMPAVCriticalErrorEvent eventWithError:_playerItem.error]];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)itemChangedEventOccured:(BBCSMPAVPlayerItemChangedEvent *)event
{
    _playerItem = event.playerItem;
}

- (void)decoderDelegateDidChange:(BBCSMPAVDecoderDelegateDidChangeEvent *)event
{
    _decoderDelegate = [event decoderDelegate];
}

@end
