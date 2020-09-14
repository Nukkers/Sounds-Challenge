//
//  BBCSMPAVItemStatusChangedEvent.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVItemStatusChangedEvent.h"

@implementation BBCSMPAVItemStatusChangedEvent

+ (instancetype)eventWithStatus:(AVPlayerItemStatus)status
{
    return [[self alloc] initWithStatus:status];
}

- (instancetype)initWithStatus:(AVPlayerItemStatus)status
{
    self = [super init];
    if(self) {
        _status = status;
    }
    
    return self;
}

@end
