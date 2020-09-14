//
//  BBCSMPVideoSurfaceScene.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 17/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CALayer;

@protocol BBCSMPVideoSurfaceScene <NSObject>
@required

- (void)showVideoLayer:(CALayer *)videoLayer;
- (void)appear;
- (void)disappear;

@end

NS_ASSUME_NONNULL_END
