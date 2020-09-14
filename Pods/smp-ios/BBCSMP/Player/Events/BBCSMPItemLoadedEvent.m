//
//  BBCSMPItemLoadedEvent.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPItemLoadedEvent.h"

@implementation BBCSMPItemLoadedEvent

- (instancetype)initWithItem:(id<BBCSMPItem>)item
{
    self = [super init];
    if (self) {
        _item = item;
    }
    
    return self;
}

@end
