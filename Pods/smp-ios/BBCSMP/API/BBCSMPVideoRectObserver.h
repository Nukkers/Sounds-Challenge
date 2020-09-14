//
//  BBCSMPVideoRectObserver.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 27/03/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "BBCSMPObserver.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;

@protocol BBCSMPVideoRectObserver <BBCSMPObserver>
@required

- (void)player:(id<BBCSMP>)player videoRectDidChange:(CGRect)videoRect;

@end
                
NS_ASSUME_NONNULL_END
