//
//  BBCSMPUIAccessibilityStateProviding.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/02/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUIAccessibilityStateProviding.h"
#import "BBCSMPUIVoiceoverStateProviding.h"
#import "BBCSMPUISwitchControlsStateProviding.h"
#import "BBCSMPAccessibilityStateObserver.h"
#import <UIKit/UIAccessibility.h>

@implementation BBCSMPUIAccessibilityStateProviding {
    id<BBCSMPVoiceoverStateProviding> _voiceoverStateProviding;
    id<BBCSMPSwitchControlsStateProviding> _switchControlsStateProviding;
    NSMutableSet<id<BBCSMPAccessibilityStateObserver>> *_observers;
}

#pragma mark Initialization

- (instancetype)init
{
    return self = [self initWithNotificationCenter:[NSNotificationCenter defaultCenter]
                           voiceoverStateProviding:[BBCSMPUIVoiceoverStateProviding new]
                      switchControlsStateProviding:[BBCSMPUISwitchControlsStateProviding new]];
}

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
                   voiceoverStateProviding:(id<BBCSMPVoiceoverStateProviding>)voiceoverStateProviding
              switchControlsStateProviding:(id<BBCSMPSwitchControlsStateProviding>)switchControlsStateProviding
{
    self = [super init];
    if(self) {
        _observers = [NSMutableSet set];
        _voiceoverStateProviding = voiceoverStateProviding;
        _switchControlsStateProviding = switchControlsStateProviding;
        
        [notificationCenter addObserver:self
                               selector:@selector(voiceoverStatusDidChange:)
                                   name:UIAccessibilityVoiceOverStatusChanged
                                 object:nil];
        
        [notificationCenter addObserver:self
                               selector:@selector(switchControlsStatusDidChange:)
                                   name:UIAccessibilitySwitchControlStatusDidChangeNotification
                                 object:nil];
    }
    
    return self;
}

#pragma mark BBCSMPAccessibilityStateProviding

- (void)addObserver:(id<BBCSMPAccessibilityStateObserver>)observer
{
    [_observers addObject:observer];
    [self propogateVoiceoverStateToObserver:observer];
    [self propogateSwitchControlsStateToObserver:observer];
}

#pragma mark Private

- (void)voiceoverStatusDidChange:(__unused NSNotification *)notification
{
    for(id<BBCSMPAccessibilityStateObserver> observer in _observers) {
        [self propogateVoiceoverStateToObserver:observer];
    }
}

- (void)switchControlsStatusDidChange:(__unused NSNotification *)notification
{
    for(id<BBCSMPAccessibilityStateObserver> observer in _observers) {
        [self propogateSwitchControlsStateToObserver:observer];
    }
}

- (void)propogateVoiceoverStateToObserver:(id<BBCSMPAccessibilityStateObserver>)observer
{
    if(_voiceoverStateProviding.isVoiceoverRunning) {
        [observer voiceoverEnabled];
    }
    else {
        [observer voiceoverDisabled];
    }
}

- (void)propogateSwitchControlsStateToObserver:(id<BBCSMPAccessibilityStateObserver>)observer
{
    if(_switchControlsStateProviding.isSwitchControlsRunning) {
        [observer switchControlsEnabled];
    }
    else {
        [observer switchControlsDisabled];
    }
}

@end
