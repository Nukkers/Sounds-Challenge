//
// Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/04/2017.
// Copyright (c) 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPSuspendRule;
@protocol BBCSMPTimerProtocol;
@protocol BBCSMPTimerFactoryProtocol;

@interface BBCSMPSuspendMechanism : NSObject

@property (nonatomic, assign, readonly, getter=isSuspended) BOOL suspended;

- (instancetype)initWithTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory
                   suspendRule:(BBCSMPSuspendRule*)suspendRule
            suspensionCallback:(void(^)(void))suspensionCallback;

- (void) evaluateSuspendRule;
- (void) cancelPendingSuspendTransition;

@end
