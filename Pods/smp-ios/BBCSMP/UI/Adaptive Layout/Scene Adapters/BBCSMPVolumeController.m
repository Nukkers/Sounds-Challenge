//
//  BBCSMPVolumeController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPVolumeController.h"
#import "BBCSMPVolumeDrawingUtils.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation BBCSMPVolumeController {
    MPVolumeView *_volumeView;
}

#pragma mark Initialization

- (instancetype)initWithVolumeView:(MPVolumeView *)volumeView
{
    self = [super init];
    if(self) {
        _volumeView = volumeView;
        
        volumeView.showsRouteButton = NO;
        [volumeView setVolumeThumbImage:BBCSMPVolumeSliderThumbImage() forState:UIControlStateNormal];
    }
    
    return self;
}

#pragma mark BBCSMPVolumeScene

- (void)showVolumeSlider
{
    _volumeView.hidden = NO;
}

- (void)hideVolumeSlider
{
    _volumeView.hidden = YES;
}

- (void)updateVolume:(float)volume
{
    
}

@end
