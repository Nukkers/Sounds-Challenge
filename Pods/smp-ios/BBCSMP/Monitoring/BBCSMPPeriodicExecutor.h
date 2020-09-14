//
//  BBCSMPPeriodicExecutor.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 16/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPPeriodicExecutor;

@protocol BBCSMPPeriodicExecutorDelegate <NSObject>
@optional

- (void)periodicExecutorPeriodDidElapse:(BBCSMPPeriodicExecutor*)periodicExecutor;

@end

@interface BBCSMPPeriodicExecutor : NSObject

@property (nonatomic, weak, nullable) id<BBCSMPPeriodicExecutorDelegate> delegate;
@property (nonatomic, assign, readonly) NSTimeInterval periodInterval;
@property (nonatomic, assign, readonly, getter=isRunning) BOOL running;
@property (nonatomic, assign) BOOL immediatelyInvokeCallback;

- (instancetype)initWithPeriodInterval:(NSTimeInterval)periodInterval;
- (instancetype)initWithPeriodInterval:(NSTimeInterval)periodInterval delegate:(nullable id<BBCSMPPeriodicExecutorDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
