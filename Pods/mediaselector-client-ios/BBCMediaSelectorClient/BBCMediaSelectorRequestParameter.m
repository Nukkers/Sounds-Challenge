//
//  BBCMediaSelectorRequestParameter.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaSelectorRequestParameter.h"

@interface BBCMediaSelectorRequestParameter ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *value;

@end

@implementation BBCMediaSelectorRequestParameter

- (instancetype)initWithName:(NSString *)name value:(NSString *)value
{
    if ((self = [super init])) {
        _name = name;
        _value = value;
    }
    return self;
}

@end
