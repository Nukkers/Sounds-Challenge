//
//  BBCSMPItemBitrateRestrictions.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 16/09/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

BBC_SMP_DEPRECATED("Apply bitrate caps using - [BBCSMPControllable applyBitrateCap:]")
@interface BBCSMPItemBitrateRestrictions : NSObject

@property (nonatomic, assign) double cellular;
@property (nonatomic, assign) double wlan;
@property (nonatomic, assign) double airplay;

@end
