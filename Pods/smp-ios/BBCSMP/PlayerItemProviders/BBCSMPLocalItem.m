//
//  BBCSMPLocalItem.m
//  SMP
//
//  Created by Stuart Thomas on 15/06/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPLocalItem.h"
#import "BBCSMPURLResolvedContent.h"
#import "BBCSMPItemMetadata.h"

@implementation BBCSMPLocalItem

- (instancetype)init
{
    if ((self = [super init])) {
        self.metadata = [[BBCSMPItemMetadata alloc] init];
        self.allowsAirplay = YES;
        self.allowsExternalDisplay = YES;
    }
    return self;
}

- (id<BBCSMPResolvedContent>)resolvedContent
{
    return [[BBCSMPURLResolvedContent alloc] initWithContentURL:_mediaURL representsNetworkResource:NO];
}

- (void)teardown
{
}

@end
