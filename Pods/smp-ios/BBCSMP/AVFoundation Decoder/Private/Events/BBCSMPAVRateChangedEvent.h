//
//  BBCSMPAVRateChangedEvent.h
//  SMP
//
//  Created by Raj Khokhar on 03/04/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPAVRateChangedEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, readonly) float rate;

- (instancetype)initWithRate:(float)rate NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
