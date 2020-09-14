//
//  BBCSMPDecoderLayerProvider.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPLayerProvider.h"

@protocol BBCSMPDecoder;

@interface BBCSMPDecoderLayerProvider : NSObject <BBCSMPLayerProvider>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithDecoder:(id<BBCSMPDecoder>)decoder NS_DESIGNATED_INITIALIZER;

@end
