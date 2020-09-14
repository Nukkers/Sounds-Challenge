//
//  BBCHTTPUserAgentToken.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 23/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPUserAgentToken.h"

@interface BBCHTTPUserAgentToken ()

@property (nonatomic, copy, readwrite, nonnull) NSString *name;
@property (nonatomic, copy, readwrite, nonnull) NSString *version;

@end

#pragma mark -

@implementation BBCHTTPUserAgentToken

+ (instancetype)tokenWithName:(NSString *)name version:(NSString *)version
{
    return [[self alloc] initWithName:name version:version];
}

- (instancetype)initWithName:(NSString *)name version:(NSString *)version
{
    if ((self = [super init])) {
        _name = name;
        _version = version;
    }

    return self;
}

@end
