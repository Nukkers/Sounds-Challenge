//
//  BBCSMPPlayerState.h
//  BBCSMP
//
//  Created by Jon Blower on 06/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPDuration;
@class BBCSMPSize;
@class BBCSMPState;
@class BBCSMPTime;

@protocol BBCSMPPlayerState <NSObject>

@property (nonatomic, strong, readonly) BBCSMPSize* playerSize;
@property (nonatomic, strong, readonly) BBCSMPState* state BBC_SMP_DEPRECATED("Please use state observation and keep track of state yourself");
@property (nonatomic, strong, readonly) BBCSMPDuration* duration;
@property (nonatomic, strong, readonly) BBCSMPTime* time;

@end
