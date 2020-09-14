//
//  BBCSMPRelativeScaleMeasurementPolicy.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 04/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPMeasurementPolicy.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPRelativeScaleMeasurementPolicy : NSObject <BBCSMPMeasurementPolicy>
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)policyWithScaleFactor:(double)scaleFactor;
- (instancetype)initWithScaleFactor:(double)scaleFactor NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
