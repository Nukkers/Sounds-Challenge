//
//  BBCSMPAVDecoderTimeAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class AVPlayerItem;
@class BBCSMPEventBus;
@class BBCSMPDuration;
@class BBCSMPAVSeekController;

@interface BBCSMPAVDecoderTimeAdapter : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, readonly) BBCSMPDuration* duration;

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                  seekController:(BBCSMPAVSeekController*)seekController NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
