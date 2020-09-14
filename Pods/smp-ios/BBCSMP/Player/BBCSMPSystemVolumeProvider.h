//
//  BBCSMPSystemVolumeProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPVolumeProvider.h"

@interface BBCSMPSystemVolumeProvider : NSObject <BBCSMPVolumeProvider>

- (instancetype)initWithAudioSession:(id)audioSession NS_DESIGNATED_INITIALIZER;

@end
