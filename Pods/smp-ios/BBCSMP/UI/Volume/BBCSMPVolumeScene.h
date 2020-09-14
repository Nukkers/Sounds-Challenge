//
//  BBCSMPVolumeScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPVolumeScene <NSObject>
@required

- (void)showVolumeSlider;
- (void)hideVolumeSlider;
- (void)updateVolume:(float)volume;

@end
