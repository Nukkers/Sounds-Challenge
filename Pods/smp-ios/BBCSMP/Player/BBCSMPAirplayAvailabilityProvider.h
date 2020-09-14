//
//  BBCSMPAirplayAvailabilityProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAirplayAvailabilityProvider;

@protocol BBCSMPAirplayAvailabilityProviderDelegate <NSObject>
@required

- (void)airplayProviderDidResolveAirplayAvailable:(id<BBCSMPAirplayAvailabilityProvider>)airplayProvider;
- (void)airplayProviderDidResolveAirplayUnavailable:(id<BBCSMPAirplayAvailabilityProvider>)airplayProvider;

@end

@protocol BBCSMPAirplayAvailabilityProvider <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPAirplayAvailabilityProviderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
