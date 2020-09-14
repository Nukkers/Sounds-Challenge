//
//  BBCSMPDisplayCoordinator.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDisplayCoordinatorProtocol.h"
#import "BBCSMPEventBus.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class CALayer;
@protocol BBCSMPDecoderLayer;
@protocol BBCSMPPlayerObservable;
@protocol BBCSMPControllable;

@interface BBCSMPDisplayCoordinator : NSObject <BBCSMPDisplayCoordinatorProtocol>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, nullable) CALayer<BBCSMPDecoderLayer>* layer;

- (instancetype)initWithPlayer:(id<BBCSMPPlayerObservable, BBCSMPControllable>)player eventBus:(BBCSMPEventBus*)eventBus NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
