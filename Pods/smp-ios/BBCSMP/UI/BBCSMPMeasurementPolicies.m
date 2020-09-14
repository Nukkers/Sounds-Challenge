//
//  BBCSMPMeasurementPolicies.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 06/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPMeasurementPolicies.h"
#import "BBCSMPRelativeScaleMeasurementPolicy.h"

@implementation BBCSMPMeasurementPolicies

- (instancetype)init
{
    self = [super init];
    if(self) {
        _playIconMeasurementPolicy = [BBCSMPRelativeScaleMeasurementPolicy policyWithScaleFactor:5.0 / 12.0];
        _pauseIconMeasurementPolicy = [BBCSMPRelativeScaleMeasurementPolicy policyWithScaleFactor:3.0 / 8.0];
        _stopIconMeasurementPolicy = [BBCSMPRelativeScaleMeasurementPolicy policyWithScaleFactor:3.0 / 8.0];
        _dismissPlayerIconMeasurementPolicy = [BBCSMPRelativeScaleMeasurementPolicy policyWithScaleFactor:19.0 / 44.0];
        _fullscreenIconMeasurementPolicy = [BBCSMPRelativeScaleMeasurementPolicy policyWithScaleFactor:0.5];
        _closeButtonIconMeasurementPolicy = [BBCSMPRelativeScaleMeasurementPolicy policyWithScaleFactor:1.0];
    }
    
    return self;
}

@end
