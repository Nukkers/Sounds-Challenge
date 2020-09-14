//
//  BBCSMPFullscreenButton.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPContractVideoIcon.h"
#import "BBCSMPExpandVideoIcon.h"
#import "BBCSMPFullscreenButton.h"
#import "BBCSMPLeaveFullscreenIcon.h"

@implementation BBCSMPFullscreenButton

#pragma mark Overrides

- (NSString*)accessibilityIdentifier
{
    return @"smp_fullscreen_button";
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(self.enabled ? size.width : 0, size.height);
}

@end
