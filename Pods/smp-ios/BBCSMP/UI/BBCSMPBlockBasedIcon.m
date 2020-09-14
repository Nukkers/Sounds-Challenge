//
//  BBCSMPBlockBasedIcon.m
//  BBCSMP
//
//  Created by Michael Emmens on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPBlockBasedIcon.h"

@interface BBCSMPBlockBasedIcon ()

@property (nonatomic, copy) BBCSMPIconDrawingBlock block;

@end

@implementation BBCSMPBlockBasedIcon

+ (instancetype)iconWithBlock:(BBCSMPIconDrawingBlock)block
{
    return [[[self class] alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(BBCSMPIconDrawingBlock)block
{
    if ((self = [super init])) {
        _block = block;
    }
    return self;
}

- (void)drawInFrame:(CGRect)frame
{
    _block(_colour, frame);
}

@end
