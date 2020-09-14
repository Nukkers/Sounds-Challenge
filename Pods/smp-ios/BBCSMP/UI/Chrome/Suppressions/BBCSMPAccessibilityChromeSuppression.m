//
//  BBCSMPAccessibilityChromeSuppression.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAccessibilityChromeSuppression.h"
#import "BBCSMPPlayerScenes.h"
#import "BBCSMPChromeSupression.h"
#import "BBCSMPAccessibilityStateProviding.h"
#import "BBCSMPAccessibilityStateObserver.h"

NSString* const kBBCSMPVoiceoverActiveReason = @"VoiceoverReason";
NSString* const kBBCSMPSwitchControlsActiveReason = @"SwitchControlsReason";

@interface BBCSMPAccessibilityChromeSuppression () <BBCSMPAccessibilityStateObserver>
@end

#pragma mark -

@implementation BBCSMPAccessibilityChromeSuppression {
    __weak id<BBCSMPChromeSupression> _chromeSuppression;
}

#pragma mark Initialization

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                                   scenes:(id<BBCSMPPlayerScenes>)scenes
              accessibilityStateProviding:(id<BBCSMPAccessibilityStateProviding>)accessibilityStateProviding
{
    self = [super init];
    if (self) {
        _chromeSuppression = chromeSuppression;
        [accessibilityStateProviding addObserver:self];
    }

    return self;
}

#pragma mark BBCSMPAccessibilityStateObserver

- (void)voiceoverDisabled
{
    [_chromeSuppression stopSuppressingControlAutohideForReason:kBBCSMPVoiceoverActiveReason];
}

- (void)voiceoverEnabled
{
    [_chromeSuppression suppressControlAutohideForReason:kBBCSMPVoiceoverActiveReason];
}

- (void)switchControlsEnabled
{
    [_chromeSuppression suppressControlAutohideForReason:kBBCSMPSwitchControlsActiveReason];
}

- (void)switchControlsDisabled
{
    [_chromeSuppression stopSuppressingControlAutohideForReason:kBBCSMPSwitchControlsActiveReason];
}

@end
