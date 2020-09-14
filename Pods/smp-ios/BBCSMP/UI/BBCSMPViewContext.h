//
//  BBCSMPViewContext.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPBrand;
@protocol BBCSMP;
@protocol BBCSMPUIConfiguration;
@protocol BBCSMPPluginFactory;
@protocol BBCSMPStatisticsConsumer;
@protocol BBCSMPPlayerViewFullscreenPresenter;

@interface BBCSMPViewContext : NSObject

@property (nonatomic, weak, readonly) id<BBCSMP> player;
@property (nonatomic, assign, readonly) CGRect frame;
@property (nonatomic, strong, readonly) BBCSMPBrand* brand;
@property (nonatomic, strong, readonly) id<BBCSMPUIConfiguration> embeddedConfiguration;
@property (nonatomic, strong, readonly) id<BBCSMPUIConfiguration> fullscreenConfiguration;
@property (nonatomic, copy, readonly) NSSet<id<BBCSMPPluginFactory> >* pluginFactories;
@property (nonatomic, copy, readonly) NSSet<id<BBCSMPStatisticsConsumer> >* statisticsConsumers;

@end

NS_ASSUME_NONNULL_END
