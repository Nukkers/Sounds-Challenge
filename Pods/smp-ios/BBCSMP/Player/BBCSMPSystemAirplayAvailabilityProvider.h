//
//  BBCSMPSystemAirplayAvailabilityProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAirplayAvailabilityProvider.h"

NS_ASSUME_NONNULL_BEGIN

@class MPVolumeView;

@interface BBCSMPSystemAirplayAvailabilityProvider : NSObject <BBCSMPAirplayAvailabilityProvider>

- (instancetype)initWithVolumeView:(MPVolumeView *)volumeView
                notificationCenter:(NSNotificationCenter *)notificationCenter NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
