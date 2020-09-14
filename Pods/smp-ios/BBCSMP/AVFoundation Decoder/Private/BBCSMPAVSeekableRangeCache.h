//
//  BBCSMPAVSeekableRangeCache.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPEventBus;
@class BBCSMPTimeRange;
@protocol AVPlayerProtocol;

@interface BBCSMPAVSeekableRangeCache : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) BBCSMPTimeRange *seekableTimeRange;

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus NS_DESIGNATED_INITIALIZER;

- (void)update;

@end

NS_ASSUME_NONNULL_END
