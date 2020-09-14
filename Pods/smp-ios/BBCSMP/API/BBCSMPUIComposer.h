//
//  BBCSMPUIComposer.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 09/05/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMP;
@protocol BBCSMPStateObservable;
@protocol BBCSMPUIBuilder;
@protocol BBCSMPVideoSurfaceManager;

@protocol BBCSMPUIComposer <NSObject>
@required

- (id<BBCSMPUIBuilder>)createBuilderWithPlayer:(id<BBCSMP, BBCSMPStateObservable>)player
                           videoSurfaceManager:(id<BBCSMPVideoSurfaceManager>)videoSurfaceManager;

@end

NS_ASSUME_NONNULL_END
