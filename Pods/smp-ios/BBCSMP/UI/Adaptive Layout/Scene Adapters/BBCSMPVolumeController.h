//
//  BBCSMPVolumeController.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPVolumeScene.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class MPVolumeView;
@class UIImage;

FOUNDATION_EXTERN UIImage * BBCSMPVolumeSliderThumbImage(void);

@interface BBCSMPVolumeController : NSObject <BBCSMPVolumeScene>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithVolumeView:(MPVolumeView *)volumeView NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
