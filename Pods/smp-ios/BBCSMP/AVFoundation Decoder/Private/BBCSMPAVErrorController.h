//
//  BBCSMPAVErrorController.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;

@interface BBCSMPAVErrorController : NSObject
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
