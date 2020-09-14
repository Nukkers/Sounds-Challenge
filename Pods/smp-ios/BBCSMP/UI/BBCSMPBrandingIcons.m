//
//  BBCSMPBrandingIcons.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPBrandingIcons.h"
#import "BBCSMPIconFactory.h"
#import "BBCSMPSubtitlesIcon.h"
#import "BBCSMPPictureInPictureIcon.h"
#import "BBCSMPLeaveFullscreenIcon.h"
#import "BBCSMPEnterFullscreenIcon.h"
#import "BBCSMPBackArrowIcon.h"

@implementation BBCSMPBrandingIcons

#pragma mark Overrides

- (instancetype)init
{
    self = [super init];
    if (self) {
        _audioPlayIcon = [BBCSMPIconFactory audioPlayIcon];
        _videoPlayIcon = [BBCSMPIconFactory playIcon];
        _pauseIcon = [BBCSMPIconFactory pauseIcon];
        _stopIcon = [BBCSMPIconFactory stopIcon];
        _subtitlesIcon = [BBCSMPSubtitlesIcon new];
#if !(TARGET_OS_TV)
        _enterPictureInPictureIcon = [BBCSMPEnablePictureInPictureIcon new];
        _exitPictureInPictureIcon = [BBCSMPDisablePictureInPictureIcon new];
#endif
        _enterFullscreenIcon = [[BBCSMPEnterFullscreenIcon alloc] init];
        _leaveFullscreenIcon = [[BBCSMPLeaveFullscreenIcon alloc] init];
        _closePlayerIcon = [[BBCSMPBackArrowIcon alloc] init];
    }

    return self;
}

@end
