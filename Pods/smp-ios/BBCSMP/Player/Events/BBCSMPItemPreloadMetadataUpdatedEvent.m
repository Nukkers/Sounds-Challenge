//
//  BBCSMPItemPreloadMetadataUpdatedEvent.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"

@interface BBCSMPItemPreloadMetadataUpdatedEvent ()

@property (nonatomic, strong, readwrite) BBCSMPItemPreloadMetadata *preloadMetadata;

@end

#pragma mark -

@implementation BBCSMPItemPreloadMetadataUpdatedEvent

- (instancetype)initWithPreloadMetdata:(BBCSMPItemPreloadMetadata *)preloadMetadata
{
    self = [super init];
    if(self) {
        _preloadMetadata = preloadMetadata;
    }
    
    return self;
}

@end
