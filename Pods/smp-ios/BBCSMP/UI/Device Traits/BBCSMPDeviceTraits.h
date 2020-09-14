//
//  BBCSMPDeviceTraits.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 31/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@protocol BBCSMPDeviceTraits <NSObject>
@required

@property (nonatomic, readonly) CGFloat scale;
@property (nonatomic, readonly) BOOL homeIndicatorAvailable;

@end
