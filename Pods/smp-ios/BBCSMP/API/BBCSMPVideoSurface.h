//
//  BBCSMPVideoSurface.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPVideoSurfaceContext;

typedef NSUInteger BBCSMPVideoSurfacePriority;

@protocol BBCSMPVideoSurface <NSObject>
@required

@property (readonly) BBCSMPVideoSurfacePriority priority;
@property (readonly) BOOL shouldPlayInBackground;
@property (readonly) BOOL shouldPauseWhenDetached;

- (void)attachWithContext:(BBCSMPVideoSurfaceContext*)context;
- (void)detach;

@end

NS_ASSUME_NONNULL_END
