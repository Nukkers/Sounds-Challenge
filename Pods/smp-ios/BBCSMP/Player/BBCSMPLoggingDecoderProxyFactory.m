//
//  BBCSMPLoggingDecoderProxyFactory.m
//  SMP
//
//  Created by Thomas Sherwood on 09/02/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPLoggingDecoderProxyFactory.h"
#import "BBCSMPDecoderLoggingProxy.h"

@implementation BBCSMPLoggingDecoderProxyFactory {
    id<BBCSMPDecoderFactory> _decoderFactory;
}

+ (instancetype)loggingFactoryWithDecoderFactory:(id<BBCSMPDecoderFactory>)decoderFactory
{
    return [[self alloc] initWithDecoderFactory:decoderFactory];
}

- (instancetype)initWithDecoderFactory:(id<BBCSMPDecoderFactory>)decoderFactory
{
    self = [super init];
    if (self) {
        _decoderFactory = decoderFactory;
    }
    
    return self;
}

- (id<BBCSMPDecoder>)createDecoder
{
    id<BBCSMPDecoder> decoder = [_decoderFactory createDecoder];
    return [BBCSMPDecoderLoggingProxy proxyForDecoder:decoder];
}

@end
