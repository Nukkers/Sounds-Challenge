//
//  BBCSMPAVBufferingEvent.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 17/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVBufferingEvent.h"

@implementation BBCSMPAVBufferingEvent

+ (instancetype)eventWithBuffering:(BOOL)buffering
{
    return [[self alloc] initWithBuffering:buffering];
}

- (instancetype)initWithBuffering:(BOOL)buffering
{
    self = [super init];
    if(self) {
        _buffering = buffering;
    }
    
    return self;
}

@end
