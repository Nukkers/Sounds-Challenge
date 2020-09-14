//
//  BBCSMPAVAudioSessionRouterAdapter.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 10/04/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPAudioRouter.h"

NS_ASSUME_NONNULL_BEGIN

@class AVAudioSession;

@interface BBCSMPAVAudioSessionRouterAdapter : NSObject <BBCSMPAudioRouter>

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
                              audioSession:(AVAudioSession *)audioSession NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
