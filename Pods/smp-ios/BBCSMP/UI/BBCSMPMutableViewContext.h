//
//  BBCSMPMutableViewContext.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 18/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPViewContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPMutableViewContext : BBCSMPViewContext

@property (nonatomic, weak) id<BBCSMP> player;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, strong) BBCSMPBrand* brand;
@property (nonatomic, strong) id<BBCSMPUIConfiguration> embeddedConfiguration;
@property (nonatomic, strong) id<BBCSMPUIConfiguration> fullscreenConfiguration;
@property (nonatomic, copy) NSSet<id<BBCSMPPluginFactory> >* pluginFactories;
@property (nonatomic, copy) NSSet<id<BBCSMPStatisticsConsumer> >* statisticsConsumers;

@end

NS_ASSUME_NONNULL_END
