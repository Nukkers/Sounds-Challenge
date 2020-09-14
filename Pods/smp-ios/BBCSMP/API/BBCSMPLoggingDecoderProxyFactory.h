//
//  BBCSMPLoggingDecoderProxyFactory.h
//  SMP
//
//  Created by Thomas Sherwood on 09/02/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPDecoderFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPLoggingDecoderProxyFactory : NSObject <BBCSMPDecoderFactory>
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)loggingFactoryWithDecoderFactory:(id<BBCSMPDecoderFactory>)decoderFactory;

@end

NS_ASSUME_NONNULL_END
