//
//  BBCSMPAVRateChangedEvent.m
//  SMP
//
//  Created by Raj Khokhar on 03/04/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPAVRateChangedEvent.h"

@implementation BBCSMPAVRateChangedEvent

- (instancetype)initWithRate:(float)rate
{
    self = [super init];
    if (self) {
        _rate = rate;
    }
    
    return self;
}

@end
