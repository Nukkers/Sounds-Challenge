//
//  BBCSMPAVCriticalErrorEvent.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAVCriticalErrorEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, nullable, readonly) NSError* error;

+ (instancetype)event;
+ (instancetype)eventWithError:(NSError *)error;
- (instancetype)initWithError:(nullable NSError*)error NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
