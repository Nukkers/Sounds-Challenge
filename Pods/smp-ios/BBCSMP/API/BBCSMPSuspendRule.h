//
//  BBCSMPSuspendRule.h
//  BBCSMP
//
//  Created by Raj Khokhar on 25/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBCSMPSuspendRule : NSObject

+ (instancetype)suspendAfter:(NSTimeInterval)seconds NS_SWIFT_NAME(suspend(after:));

- (NSTimeInterval) intervalBeforeSuspend;

@end
