//
//  BBCSMPMediaRepository.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/05/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <SMP/SMP.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPDecoder;

NS_SWIFT_NAME(MediaRepository)
@protocol BBCSMPMediaRepository <BBCSMPItemProvider>
@required

- (void)resolvePlayableMediaWithResolutionHandler:(void(^)(id<BBCSMPDecoder>))resolutionHandler failureHandler:(void(^)(NSError *))failureHandler;

@end

NS_ASSUME_NONNULL_END
