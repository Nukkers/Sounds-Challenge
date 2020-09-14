//
//  BBCSMPDefaultPlayerViewFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPPlayerViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPMeasurementPolicies;
@protocol BBCSMPSafeAreaGuideProvidingFactory;

@interface BBCSMPDefaultPlayerViewFactory : NSObject<BBCSMPPlayerViewFactory>

- (instancetype)initWithMeasurementPolicies:(BBCSMPMeasurementPolicies *)measurementPolicies
              safeAreaGuideProvidingFactory:(id<BBCSMPSafeAreaGuideProvidingFactory>)safeAreaGuideProvidingFactory NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
