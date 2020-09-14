//
//  BBCSMPDecoderLayerProvider.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDecoder.h"
#import "BBCSMPDecoderLayer.h"
#import "BBCSMPDecoderLayerProvider.h"

@interface BBCSMPDecoderLayerProvider ()

@property (nonatomic, weak) id<BBCSMPDecoder> decoder;

@end

#pragma mark -

@implementation BBCSMPDecoderLayerProvider

- (instancetype)initWithDecoder:(id<BBCSMPDecoder>)decoder
{
    self = [super init];
    if (self) {
        _decoder = decoder;
    }

    return self;
}

- (CALayer<BBCSMPDecoderLayer>*)produceLayer
{
    return _decoder.decoderLayer;
}

@end
