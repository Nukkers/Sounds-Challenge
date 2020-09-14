//
//  BBCSMPSize.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 25/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <Foundation/Foundation.h>

@interface BBCSMPSize : NSObject

@property (nonatomic, assign, readonly) CGSize size;

+ (instancetype)sizeWithCGSize:(CGSize)size NS_SWIFT_NAME(sizeWithCGSize(_:));

@end
