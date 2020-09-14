//
//  BBCSMPDecoderCurrentPosition.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DecoderCurrentPosition)
@interface BBCSMPDecoderCurrentPosition : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) NSTimeInterval seconds;

+ (instancetype)zeroPosition;
+ (instancetype)currentPositionWithSeconds:(NSTimeInterval)seconds;

@end

NS_ASSUME_NONNULL_END
