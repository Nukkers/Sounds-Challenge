//
//  BBCSMPLayerProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/NSObject.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPDecoderLayer;

@protocol BBCSMPLayerProvider <NSObject>
@required

- (CALayer<BBCSMPDecoderLayer>*)produceLayer;

@end

NS_ASSUME_NONNULL_END
