//
//  BBCSMPPluginFactory.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 03/07/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPPlugin;
@protocol BBCSMPPluginEnvironment;

@protocol BBCSMPPluginFactory <NSObject>

- (id<BBCSMPPlugin>)createPluginWithEnvironment:(id<BBCSMPPluginEnvironment>)environment NS_SWIFT_NAME(createPlugin(withEnvironment:));

@end

NS_ASSUME_NONNULL_END
