//
//  BBCSMPUIScreenAdapterFactory.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPExternalDisplayProducer.h"

NS_ASSUME_NONNULL_BEGIN

@class UIScreen;

@protocol BBCSMPDisplayCoordinatorProtocol;

@interface BBCSMPUIScreenAdapterFactory : NSObject <BBCSMPExternalDisplayProducer>

- (instancetype)initWithNotificationCenter:(NSNotificationCenter*)notificationCenter
                                   screens:(NSArray<UIScreen*>*)screens NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
