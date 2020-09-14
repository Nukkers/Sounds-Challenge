//
//  BBCSMPAccessibilityAnnouncerPresenter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityAnnouncer.h"
#import "BBCSMPAccessibilityAnnouncerPresenter.h"
#import "BBCSMPAccessibilityIndex.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPTimerFactoryProtocol.h"
#import "BBCSMPUIConfiguration.h"
#import "BBCSMPBrand.h"
#import "BBCSMPPresentationControllers.h"
#import "BBCSMPScrubberController.h"
#import "BBCSMPAccessibilityStateAction.h"
#import "BBCSMPPlaybackPausedStateAction.h"
#import "BBCSMPPlaybackEndedStateAction.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPAccessibilityAnnouncerPresenter () <BBCSMPScrubberInteractionObserver,
                                                     BBCSMPPlaybackStateObserver>
@property (nonatomic, copy, nonnull) void(^actionOnUnprepared)(void);
@property (nonatomic, assign) BOOL suppressAnnouncementsAfterScrub;
@property (nonatomic, strong) id<BBCSMPAccessibilityAnnouncer> announcer;
@property (nonatomic, strong) BBCSMPAccessibilityIndex* accessibilityIndex;
@end

#pragma mark -

@implementation BBCSMPAccessibilityAnnouncerPresenter {
    id<BBCSMPTimerFactoryProtocol> _timerFactory;
    id<BBCSMPUIConfiguration> _configuration;
    id<BBCSMPTimerProtocol> _bufferingReannouncementTimer;
    id<SMPPlaybackState> _playbackState;
    id<BBCSMPAccessibilityStateAction> pausedAction;
    id<BBCSMPAccessibilityStateAction> endedAction;
    NSDictionary<NSNumber *, id<BBCSMPAccessibilityStateAction>> *_stateActions;
}

#pragma mark Initialization

- (instancetype)initWithContext:(BBCSMPPresentationContext *)context
{
    self = [super init];
    if (self) {
        _announcer = context.accessibilityAnnouncer;
        _accessibilityIndex = context.brand.accessibilityIndex;
        _timerFactory = context.timerFactory;
        _configuration = context.configuration;
        _actionOnUnprepared = ^void(){};
        
        pausedAction = [[BBCSMPPlaybackPausedStateAction alloc] initWithAnnouncer:_announcer
                                                                      accessibilityIndex:_accessibilityIndex];
        endedAction = [[BBCSMPPlaybackEndedStateAction alloc] initWithAnnouncer:_announcer
                                                                    accessibilityIndex:_accessibilityIndex];
        _stateActions = @{@(BBCSMPStatePaused): pausedAction,
                          @(BBCSMPStateEnded): endedAction};
        
        [context.presentationControllers.scrubberController addObserver:self];
        [context.player addStateObserver:self];
    }

    return self;
}

#pragma mark BBCSMPScrubberInteractionObserver

- (void)scrubberDidFinishScrubbing
{
    [self supressAnnouncementsAfterScrubIfPlaying];
}

- (void)scrubberDidReceiveAccessibilityIncrement
{
    [self supressAnnouncementsAfterScrubIfPlaying];
}

- (void)scrubberDidReceiveAccessibilityDecrement
{
    [self supressAnnouncementsAfterScrubIfPlaying];
}

- (void)scrubberDidBeginScrubbing { }
- (void)scrubberDidScrubToPosition:(NSNumber *)position { }

-(void)supressAnnouncementsAfterScrubIfPlaying
{
    id playbackState = _playbackState;
    if([playbackState isKindOfClass:[SMPPlaybackStatePlaying class]]) {
        self.suppressAnnouncementsAfterScrub = YES;
    }
}

#pragma mark Timer Callback

- (void)bufferingAnnouncementTimerDidElapse
{
    [_announcer announce:[_accessibilityIndex announcementForEvent:BBCSMPAccessibilityEventPlayerBufferingForExtendedPeriod]];
    [_bufferingReannouncementTimer stop];
}

- (void)state:(id<SMPPlaybackState> _Nonnull)state {
    _playbackState = state;
    id playbackState = _playbackState;
    
    if ([playbackState isKindOfClass:[SMPPlaybackStatePlaying class]]) {
        if(self.suppressAnnouncementsAfterScrub) {
            self.suppressAnnouncementsAfterScrub = NO;
        }
        else {
            [_announcer announce:[_accessibilityIndex announcementForEvent:BBCSMPAccessibilityEventPlaybackStarted]];
        }
        
        __weak typeof(self) weakSelf = self;
        _actionOnUnprepared = ^void(){
            weakSelf.suppressAnnouncementsAfterScrub = NO;
            [weakSelf.announcer announce:[weakSelf.accessibilityIndex announcementForEvent:BBCSMPAccessibilityEventPlaybackStopped]];
        };

    }
    
    if ([playbackState isKindOfClass:[SMPPlaybackStateLoading class]]) {
        _bufferingReannouncementTimer = [_timerFactory timerWithInterval:[_configuration accessibilityStillBufferingAnnouncementDelay]
                                                                  target:self
                                                                selector:@selector(bufferingAnnouncementTimerDidElapse)];
        
        if(!_suppressAnnouncementsAfterScrub) {
            [_announcer announce:[_accessibilityIndex announcementForEvent:BBCSMPAccessibilityEventPlayerBuffering]];
        }
    } else {
        [_bufferingReannouncementTimer stop];
    }

    if ([playbackState isKindOfClass:[SMPPlaybackStateEnded class]]) {
        [_announcer announce:[_accessibilityIndex announcementForEvent:BBCSMPAccessibilityEventPlaybackEnded]];
        self.suppressAnnouncementsAfterScrub = NO;
    }
    
    if ([playbackState isKindOfClass:[SMPPlaybackStateUnprepared class]]) {
        _actionOnUnprepared();
    }

    if ([playbackState isKindOfClass:[SMPPlaybackStateFailed class]]) {
        _suppressAnnouncementsAfterScrub = NO;
    }
    
    if ([playbackState isKindOfClass:[SMPPlaybackStatePaused class]]) {
        [pausedAction executeAction];
    }
}

@end
