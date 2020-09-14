//
//  BBCSMPVolumeView.h
//  BBCSMP
//
//  Created by Timothy James Condon on 04/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPVolumeScene.h"
#import "BBCSMPTransportControlsScene.h"
#import <MediaPlayer/MediaPlayer.h>

@class BBCSMPBrand;

@interface BBCSMPVolumeView : MPVolumeView <BBCSMPVolumeScene>

- (instancetype)initWithDelegate:(id<BBCSMPTransportControlsScene>)delegate;
- (void)setBrand:(BBCSMPBrand*)brand;

@end
