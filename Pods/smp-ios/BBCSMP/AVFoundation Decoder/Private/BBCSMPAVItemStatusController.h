//
//  BBCSMPAVPlaybackStatusController.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;
@protocol AVPlayerProtocol;

@interface BBCSMPAVItemStatusController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
                          player:(id<AVPlayerProtocol>)player  NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
