//
//  BBCSMPAirplayObserver.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAirplayObserver <BBCSMPObserver>

- (void)airplayAvailabilityChanged:(NSNumber*)available;
- (void)airplayActivationChanged:(NSNumber*)active;

@end

NS_ASSUME_NONNULL_END
