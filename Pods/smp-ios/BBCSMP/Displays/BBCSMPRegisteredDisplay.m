//
//  BBCSMPRegisteredDisplay.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 30/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPRegisteredDisplay.h"

@interface BBCSMPRegisteredDisplay ()

@property (nonatomic, weak, readwrite) id<BBCSMPVideoSurface> videoSurface;

@end

#pragma mark -

@implementation BBCSMPRegisteredDisplay

#pragma mark Initialization

- (instancetype)initWithVideoSurface:(id<BBCSMPVideoSurface>)videoSurface
{
    self = [super init];
    if(self) {
        _videoSurface = videoSurface;
    }
    
    return self;
}

@end
