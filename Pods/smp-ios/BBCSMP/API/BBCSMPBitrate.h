//
//  BBCSMPBitrate.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

typedef double BBCSMPBitsPerSecond;

NS_SWIFT_NAME(Bitrate)
@interface BBCSMPBitrate : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) BBCSMPBitsPerSecond bitsPerSecond;

+ (instancetype)bitrateWithBitsPerSecond:(BBCSMPBitsPerSecond)bitsPerSecond;
- (instancetype)initWithBitsPerSecond:(BBCSMPBitsPerSecond)bitsPerSecond NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
