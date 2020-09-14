//
//  BBCSMPIconButton.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 01/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPIcon;
@protocol BBCSMPMeasurementPolicy;

@interface BBCSMPIconButton : BBCSMPButton

@property (nonatomic, strong, nullable) id<BBCSMPIcon> icon;
@property (nonatomic, strong, nullable) id<BBCSMPMeasurementPolicy> measurementPolicy;
@property (nonatomic, strong, nullable) UIColor *highlightedStateColor;

@end

NS_ASSUME_NONNULL_END
