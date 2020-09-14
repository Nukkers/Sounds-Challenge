//
//  BBCSMPPlaybackControlsController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPPlaybackControlsController.h"
#import <UIKit/UIView.h>

@implementation BBCSMPPlaybackControlsController {
    UIView *_playbackControlsContainer;
}

#pragma mark Initialization

- (instancetype)initWithPlaybackControlsContainer:(UIView *)playbackControlsContainer
{
    self = [super init];
    if(self) {
        _playbackControlsContainer = playbackControlsContainer;
    }
    
    return self;
}

#pragma mark BBCSMPPlaybackControlsScene

- (void)hide
{
    _playbackControlsContainer.hidden = YES;
}

- (void)show
{
    _playbackControlsContainer.hidden = NO;
}

@end
