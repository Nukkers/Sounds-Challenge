//
//  BBCSMPAVPeriodicObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;

@interface BBCSMPAVPeriodicObserver : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus
              observationContext:(BBCSMPAVObservationContext *)context
                 updateFrequency:(CMTime)updateFrequency NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
