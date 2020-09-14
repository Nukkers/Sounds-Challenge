//
//  BBCSMPBitrate.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPBitrate.h"

@implementation BBCSMPBitrate

+ (instancetype)bitrateWithBitsPerSecond:(BBCSMPBitsPerSecond)bitsPerSecond
{
    return [[self alloc] initWithBitsPerSecond:bitsPerSecond];
}

- (instancetype)initWithBitsPerSecond:(BBCSMPBitsPerSecond)bitsPerSecond
{
    self = [super init];
    if (self) {
        _bitsPerSecond = bitsPerSecond;
    }
    
    return self;
}

- (NSString *)description
{
    NSString *bitrateString = [NSString stringWithFormat:@" (%li bps)", (long)_bitsPerSecond];
    return [[super description] stringByAppendingString:bitrateString];
}

@end
