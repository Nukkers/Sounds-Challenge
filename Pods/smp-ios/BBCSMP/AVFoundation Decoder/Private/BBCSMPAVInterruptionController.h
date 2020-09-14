//
//  BBCSMPAVInterruptionController.h
//  SMP
//
//  Created by Ryan Johnstone on 29/01/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPAVDecoder.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;

@interface BBCSMPAVInterruptionController : NSObject

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus;

@end

NS_ASSUME_NONNULL_END
