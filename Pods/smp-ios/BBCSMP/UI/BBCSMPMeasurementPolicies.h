//
//  BBCSMPMeasurementPolicies.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 06/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPMeasurementPolicy;

@interface BBCSMPMeasurementPolicies : NSObject

@property (nonatomic, strong) id<BBCSMPMeasurementPolicy> playIconMeasurementPolicy;
@property (nonatomic, strong) id<BBCSMPMeasurementPolicy> pauseIconMeasurementPolicy;
@property (nonatomic, strong) id<BBCSMPMeasurementPolicy> stopIconMeasurementPolicy;
@property (nonatomic, strong) id<BBCSMPMeasurementPolicy> dismissPlayerIconMeasurementPolicy;
@property (nonatomic, strong) id<BBCSMPMeasurementPolicy> fullscreenIconMeasurementPolicy;
@property (nonatomic, strong) id<BBCSMPMeasurementPolicy> closeButtonIconMeasurementPolicy;

@end

NS_ASSUME_NONNULL_END
