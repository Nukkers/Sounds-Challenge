//
//  BBCSMPAudioRouter.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 10/04/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPAudioRouterObserver;

NS_SWIFT_NAME(AudioRouter)
@protocol BBCSMPAudioRouter <NSObject>

- (void)addAudioRouterObserver:(id<BBCSMPAudioRouterObserver>)observer;

@end

NS_SWIFT_NAME(AudioRouterObserver)
@protocol BBCSMPAudioRouterObserver <NSObject>

- (void)audioOutputDidChangeToRouteNamed:(NSString *)routeName;

@end

NS_ASSUME_NONNULL_END
