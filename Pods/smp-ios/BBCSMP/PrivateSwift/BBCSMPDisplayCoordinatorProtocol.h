//
//  BBCSMPDisplayCoordinatorProtocol.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPVideoSurface;

@protocol BBCSMPDisplayCoordinatorProtocol <NSObject>
@required

@property (readonly) BOOL playbackShouldContinueWhenBackgrounding;

- (void)attachVideoSurface:(nonnull id<BBCSMPVideoSurface>)videoSurface;
- (void)detachVideoSurface:(nonnull id<BBCSMPVideoSurface>)videoSurface;

@end
