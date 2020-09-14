//
//  BBCSMPLayoutGuideSafeAreaGuideProviding.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 28/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPSafeAreaGuideProviding.h"

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE_IOS(11.0)
@interface BBCSMPLayoutGuideSafeAreaGuideProviding : NSObject <BBCSMPSafeAreaGuideProviding>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithView:(UIView *)view NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
