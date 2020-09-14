//
//  BBCSMPItemPreloadMetadataUpdatedEvent.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@class BBCSMPItemPreloadMetadata;

@interface BBCSMPItemPreloadMetadataUpdatedEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) BBCSMPItemPreloadMetadata *preloadMetadata;

- (instancetype)initWithPreloadMetdata:(BBCSMPItemPreloadMetadata *)preloadMetadata NS_DESIGNATED_INITIALIZER;

@end
