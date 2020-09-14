//
//  BBCSMPAVInterruptionController.m
//  SMP
//
//  Created by Ryan Johnstone on 29/01/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BBCSMPAVInterruptionController.h"
#import "BBCSMPDecoderDelegate.h"
#import "AVPlayerProtocol.h"
#import "BBCSMPAVPrerollCompleteEvent.h"
#import "BBCSMPEventBus.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPAVInterruptionController {
    BBCSMPEventBus *_eventBus;
    AVPlayerItem *_playerItem;
    BOOL _decoderInterrupted;
    __weak id<BBCSMPDecoderDelegate> _decoderDelegate;
}

#pragma mark Initialization

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
{
    self = [super init];
    if (self) {
        _eventBus = eventBus;
        
        NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
        
        [notificationCenter addObserver:self selector:@selector(interruptedNotification:) name:AVAudioSessionInterruptionNotification object:nil];
        
        [_eventBus addTarget:self selector:@selector(playerItemDidChange:) forEventType:[BBCSMPAVPlayerItemChangedEvent class]];
        [_eventBus addTarget:self selector:@selector(playerDidPreroll:) forEventType:[BBCSMPAVPrerollCompleteEvent class]];
        [_eventBus addTarget:self selector:@selector(decoderDelegateDidChange:) forEventType:[BBCSMPAVDecoderDelegateDidChangeEvent class]];
    }
    
    return self;
}

#pragma mark Domain Event Handlers

- (void)playerItemDidChange:(BBCSMPAVPlayerItemChangedEvent *)event
{
    _playerItem = event.playerItem;
}

- (void)playerDidPreroll:(BBCSMPAVPrerollCompleteEvent *)event
{
    if (!_decoderInterrupted) {
        [_decoderDelegate decoderReady];
    }
}

- (void)decoderDelegateDidChange:(BBCSMPAVDecoderDelegateDidChangeEvent *)event
{
    _decoderDelegate = [event decoderDelegate];
}

#pragma mark Audio Session Interruption Event Handling

- (void)interruptedNotification:(NSNotification*)notification
{
    if ([self isNotification:notification ofType:AVAudioSessionInterruptionTypeBegan]) {
        if (@available(iOS 10.3, *)) {
            bool suspended = notification.userInfo[AVAudioSessionInterruptionWasSuspendedKey];
            if (!suspended) {
                _decoderInterrupted = YES;
            }
        } else {
            _decoderInterrupted = YES;
        }
    }

    if ([self isNotification:notification ofType:AVAudioSessionInterruptionTypeEnded] && _playerItem.isPlaybackLikelyToKeepUp) {
        [_decoderDelegate decoderReady];
    }
}

- (BOOL)isNotification:(NSNotification *)notification ofType:(AVAudioSessionInterruptionType)type
{
    NSDictionary *userInfo = [notification userInfo];
    NSNumber* interruptionType = userInfo[AVAudioSessionInterruptionTypeKey];
    
    return [interruptionType integerValue] == type;
}

@end
