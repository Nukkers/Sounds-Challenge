//
//  BBCSMPURLResolvedContent.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPURLResolvedContent.h"

@implementation BBCSMPURLResolvedContent

@synthesize content = _content;
@synthesize networkResource = _networkResource;

#pragma mark Initialization

- (instancetype)initWithContentURL:(NSURL*)URL representsNetworkResource:(BOOL)networkResource
{
    self = [super init];
    if (self) {
        _content = URL;
        _networkResource = networkResource;
    }

    return self;
}

@end
