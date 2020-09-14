//
//  BBCSMPPreloadMetadataObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood on 17/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPObserver.h"

@class BBCSMPItemPreloadMetadata;

@protocol BBCSMPPreloadMetadataObserver <BBCSMPObserver>

- (void)preloadMetadataUpdated:(BBCSMPItemPreloadMetadata*)preloadMetadata;

@end
