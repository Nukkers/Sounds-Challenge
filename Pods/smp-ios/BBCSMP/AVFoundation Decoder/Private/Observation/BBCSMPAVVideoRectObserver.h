//
//  BBCSMPAVVideoRectObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class AVPlayerLayer;
@class BBCSMPAVObservationContext;

@interface BBCSMPAVVideoRectObserver : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                              decoderLayer:(AVPlayerLayer*)layer NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
