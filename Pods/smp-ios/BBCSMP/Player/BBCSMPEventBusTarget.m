//
//  BBCSMPEventBusTarget.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPEventBusTarget.h"

@implementation BBCSMPEventBusTarget

- (instancetype)initWithTarget:(id)target selector:(SEL)selector
{
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
    }
    
    return self;
}

@end
