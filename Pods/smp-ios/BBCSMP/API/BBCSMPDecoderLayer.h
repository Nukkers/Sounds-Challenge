//
//  BBCSMPDecoderLayer.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPDecoderLayer <NSObject>
@required

@property (copy) NSString* videoGravity;
@property (nonatomic, readonly) CGRect videoRect;

@end

NS_ASSUME_NONNULL_END
