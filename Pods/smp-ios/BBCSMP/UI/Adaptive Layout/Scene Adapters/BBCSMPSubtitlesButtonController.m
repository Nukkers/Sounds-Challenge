//
//  BBCSMPSubtitlesButtonController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPSubtitlesButtonController.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPSubtitlesButtonController {
    UIButton *_enableSubtitlesButton;
    UIButton *_disableSubtitlesButton;
}

#pragma mark Initialization

- (instancetype)initWithEnableSubtitlesButton:(UIButton *)enableSubtitlesButton
                       disableSubtitlesButton:(UIButton *)disableSubtitlesButton
{
    self = [super init];
    if(self) {
        _enableSubtitlesButton = enableSubtitlesButton;
        _disableSubtitlesButton = disableSubtitlesButton;
        
        [enableSubtitlesButton addTarget:self
                                  action:@selector(handleEnableSubtitlesButtonTap)
                        forControlEvents:UIControlEventTouchUpInside];
        [disableSubtitlesButton addTarget:self
                                   action:@selector(handleDisableSubtitlesButtonTap)
                         forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

#pragma mark Private

- (void)handleEnableSubtitlesButtonTap
{
    [_enableSubtitlesDelegate enableSubtitlesButtonSceneDidReceiveTap:self];
}

- (void)handleDisableSubtitlesButtonTap
{
    [_disableSubtitlesDelegate disableSubtitlesButtonSceneDidReceiveTap:self];
}

#pragma mark BBCSMPSubtitlesButtonScene

@synthesize subtitlesButtonDelegate = _subtitlesButtonDelegate;
@synthesize enableSubtitlesDelegate = _enableSubtitlesDelegate;
@synthesize disableSubtitlesDelegate = _disableSubtitlesDelegate;

- (void)showEnableSubtitlesButton
{
    _enableSubtitlesButton.hidden = NO;
}

- (void)hideEnableSubtitlesButton
{
    _enableSubtitlesButton.hidden = YES;
}

- (void)showDisableSubtitlesButton
{
    _disableSubtitlesButton.hidden = NO;
}

- (void)hideDisableSubtitlesButton
{
    _disableSubtitlesButton.hidden = YES;
}

@end
