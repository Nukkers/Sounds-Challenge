//
//  BBCSMPDuration.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDuration.h"

@interface BBCSMPDuration ()

@property (nonatomic, assign) NSTimeInterval seconds;

@end

@implementation BBCSMPDuration

+ (instancetype)duration:(NSTimeInterval)seconds
{
    return [[BBCSMPDuration alloc] initWithSeconds:seconds];
}

- (instancetype)initWithSeconds:(NSTimeInterval)seconds
{
    if ((self = [super init])) {
        self.seconds = seconds;
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %fs", [super description], _seconds];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]])
        return NO;

    return ([(BBCSMPDuration*)object seconds] == _seconds);
}

@end
