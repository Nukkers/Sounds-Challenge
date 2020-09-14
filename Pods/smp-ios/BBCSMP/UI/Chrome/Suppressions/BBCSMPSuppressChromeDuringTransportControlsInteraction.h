//
//  BBCSMPSuppressChromeDuringTransportControlsInteraction.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPChromeSupression;
@protocol BBCSMPTransportControlsScene;

@interface BBCSMPSuppressChromeDuringTransportControlsInteraction : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithChromeSuppression:(id<BBCSMPChromeSupression>)chromeSuppression
                   transportControlsScene:(id<BBCSMPTransportControlsScene>)transportControlsScene NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
