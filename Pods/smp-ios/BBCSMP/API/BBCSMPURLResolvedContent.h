//
//  BBCSMPURLResolvedContent.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPResolvedContent.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPURLResolvedContent : NSObject <BBCSMPResolvedContent>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithContentURL:(NSURL*)URL representsNetworkResource:(BOOL)networkResource NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
