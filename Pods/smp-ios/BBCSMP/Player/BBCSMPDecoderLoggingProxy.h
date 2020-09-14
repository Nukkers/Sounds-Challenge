//
//  BBCSMPDecoderLoggingProxy.h
//  SMP
//
//  Created by Thomas Sherwood on 09/02/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <SMP/SMP.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPDecoderLoggingProxy : NSProxy <BBCSMPDecoder>
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)proxyForDecoder:(id<BBCSMPDecoder>)decoder;

@end

NS_ASSUME_NONNULL_END
