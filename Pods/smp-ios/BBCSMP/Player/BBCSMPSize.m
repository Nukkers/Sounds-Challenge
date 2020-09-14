//
//  BBCSMPSize.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 25/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSize.h"
#import <UIKit/UIGeometry.h>

@interface BBCSMPSize ()

@property (nonatomic, assign) CGSize size;

@end

@implementation BBCSMPSize

+ (instancetype)sizeWithCGSize:(CGSize)size
{
    return [[BBCSMPSize alloc] initWithSize:size];
}

- (instancetype)init
{
    if ((self = [super init])) {
        _size = CGSizeZero;
    }
    return self;
}

- (instancetype)initWithSize:(CGSize)size
{
    if ((self = [super init])) {
        _size = size;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]])
        return NO;

    BBCSMPSize* otherSize = (BBCSMPSize*)object;
    return CGSizeEqualToSize(otherSize.size, _size);
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %@", [super description], NSStringFromCGSize(_size)];
}

@end
