//
//  BBCSMPMediaBitrate.m
//  SMP
//
//  Created by Richard Gilpin on 21/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPMediaBitrate.h"

@implementation BBCSMPMediaBitrate

+ (instancetype)mediaBitrateWithBitrate:(double)mediaBitrate{
    return [[BBCSMPMediaBitrate alloc] initWithBitrate:mediaBitrate];
}

- (instancetype)initWithBitrate:(double)bitrate
{
    if ((self = [super init])) {
        self.mediaBitrate = bitrate;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[BBCSMPMediaBitrate class]])
        return NO;
        
    BBCSMPMediaBitrate *bitrate = (BBCSMPMediaBitrate *)object;
        return ([bitrate mediaBitrate] == _mediaBitrate);
}

@end
