//
//  BBCSMPClock.h
//  BBCSMP
//
//  Created by Ross Beazley on 12/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPClockTime;

@protocol BBCSMPClockDelegate <NSObject>

- (void)clockDidTickToTime:(BBCSMPClockTime*)clockTime;

@end

@protocol BBCSMPClock <NSObject>

- (void)addClockDelegate:(id<BBCSMPClockDelegate>)clockListener;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
