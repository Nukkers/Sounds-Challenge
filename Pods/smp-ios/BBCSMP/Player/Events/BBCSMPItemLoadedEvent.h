//
//  BBCSMPItemLoadedEvent.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 05/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@protocol BBCSMPItem;

@interface BBCSMPItemLoadedEvent : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (strong, nonatomic, readonly) id<BBCSMPItem> item;

- (instancetype)initWithItem:(id<BBCSMPItem>)item NS_DESIGNATED_INITIALIZER;

@end
