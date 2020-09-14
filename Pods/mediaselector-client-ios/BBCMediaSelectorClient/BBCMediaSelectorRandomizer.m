//
//  BBCMediaSelectorRandomizer.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 23/01/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaSelectorRandomizer.h"

@implementation BBCMediaSelectorRandomizer

- (NSUInteger)generateRandomPercentage
{
    return (arc4random() % 100) + 1;
}

@end
