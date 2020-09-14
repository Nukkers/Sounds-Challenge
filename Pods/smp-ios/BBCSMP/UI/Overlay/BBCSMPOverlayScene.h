//
//  BBCSMPOverlayScene.h
//  BBCSMP
//
//  Created by Daniel Ellis on 21/09/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPOverlayPosition.h"
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPOverlayScene <NSObject>
@required

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
