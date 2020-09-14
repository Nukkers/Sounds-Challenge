//
//  BBCSMPDecoderCurrentPosition.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDecoderCurrentPosition.h"

@implementation BBCSMPDecoderCurrentPosition

+ (instancetype)zeroPosition
{
    return [self currentPositionWithSeconds:0];
}

+ (instancetype)currentPositionWithSeconds:(NSTimeInterval)seconds
{
    BBCSMPDecoderCurrentPosition *currentPosition = [[self alloc] init];
    currentPosition->_seconds = seconds;
    
    return currentPosition;
}

- (NSString *)description
{
    NSMutableString *description = [[super description] mutableCopy];
    NSString *secondsString = [NSString stringWithFormat:@" %f seconds", _seconds];
    [description appendString:secondsString];
    
    return description;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return _seconds == [object seconds];
}

@end
