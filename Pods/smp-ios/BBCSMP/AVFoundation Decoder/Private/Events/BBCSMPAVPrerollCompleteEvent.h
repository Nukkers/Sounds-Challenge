//
//  BBCSMPAVPrerollCompleteEvent.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAVPrerollCompleteEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) BOOL prerollDidCompleteSuccessfully;

+ (instancetype)eventWithPrerollCompletionState:(BOOL)completionState;
- (instancetype)initWithPrerollCompletionState:(BOOL)completionState NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
