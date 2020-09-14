//
//  BBCSMPPlaybackPausedStateAction.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/08/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlaybackPausedStateAction.h"
#import "BBCSMPAccessibilityAnnouncer.h"
#import "BBCSMPAccessibilityIndex.h"

@implementation BBCSMPPlaybackPausedStateAction {
    id<BBCSMPAccessibilityAnnouncer> _announcer;
    BBCSMPAccessibilityIndex* _accessibilityIndex;
}

#pragma mark Initialization

- (instancetype)initWithAnnouncer:(id<BBCSMPAccessibilityAnnouncer>)announcer
               accessibilityIndex:(BBCSMPAccessibilityIndex *)index
{
    self = [super init];
    if(self) {
        _announcer = announcer;
        _accessibilityIndex = index;
    }
    
    return self;
}

#pragma mark BBCSMPAccessibilityStateAction

- (void)executeAction
{
    [_announcer announce:[_accessibilityIndex announcementForEvent:BBCSMPAccessibilityEventPlaybackPaused]];
}

@end
