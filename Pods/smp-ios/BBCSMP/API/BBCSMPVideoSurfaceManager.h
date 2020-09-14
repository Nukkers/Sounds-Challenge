//
//  BBCSMPVideoSurfaceManager.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 13/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPVideoSurface;

@protocol BBCSMPVideoSurfaceManager <NSObject>
@required

- (void)registerVideoSurface:(id<BBCSMPVideoSurface>)videoSurface NS_SWIFT_NAME(register(videoSurface:));
- (void)deregisterVideoSurface:(id<BBCSMPVideoSurface>)videoSurface NS_SWIFT_NAME(deregister(videoSurface:));

@end

NS_ASSUME_NONNULL_END
