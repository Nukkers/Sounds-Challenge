//
//  BBCSMPAVItemStatusChangedEvent.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAVItemStatusChangedEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) AVPlayerItemStatus status;

+ (instancetype)eventWithStatus:(AVPlayerItemStatus)status;
- (instancetype)initWithStatus:(AVPlayerItemStatus)status NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
