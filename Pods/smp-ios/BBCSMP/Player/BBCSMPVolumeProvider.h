//
//  BBCSMPVolumeProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPVolumeProviderDelegate

- (void)didUpdateVolume:(float)volume;

@end

@protocol BBCSMPVolumeProvider

@property (nonatomic, weak) id<BBCSMPVolumeProviderDelegate> delegate;
@property (nonatomic, assign, readonly) float currentVolume;

@end