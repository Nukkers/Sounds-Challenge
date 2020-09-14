//
//  BBCSMPAVPlayerExternalPlaybackAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPExternalPlaybackAdapter.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;
@protocol AVPlayerProtocol;

@interface BBCSMPAVExternalPlaybackAdapter : NSObject <BBCSMPExternalPlaybackAdapter>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus player:(id<AVPlayerProtocol>)player NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
