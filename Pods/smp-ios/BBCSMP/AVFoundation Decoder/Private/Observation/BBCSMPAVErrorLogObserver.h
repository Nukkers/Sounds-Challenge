//
//  BBCSMPAVErrorLogObserver.h
//  SMP
//
//  Created by Richard Gilpin on 19/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPAVObservationContext;
@class BBCSMPEventBus;

@interface BBCSMPAVErrorLogObserver : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithObservationContext:(BBCSMPAVObservationContext*)context
                                  eventBus:(BBCSMPEventBus *)eventBus NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
