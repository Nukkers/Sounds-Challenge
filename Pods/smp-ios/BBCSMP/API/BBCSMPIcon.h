//
//  BBCSMPIcon.h
//  BBCSMP
//
//  Created by Michael Emmens on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>

@class UIColor;

@protocol BBCSMPIcon <NSObject>
@required

@property (nonatomic, strong, nonnull) UIColor* colour;

- (void)drawInFrame:(CGRect)frame NS_SWIFT_NAME(draw(in:));

@end
