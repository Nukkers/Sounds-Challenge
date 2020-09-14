//
//  BBCSMPMeasurementPolicy.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 01/09/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@protocol BBCSMPMeasurementPolicy <NSObject>

- (CGRect)preferredBoundsForDrawingInRect:(CGRect)rect;

@end
