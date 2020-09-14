//
//  BBCSMPNotificationReceptionist.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPWorker;

@interface BBCSMPNotificationReceptionist : NSObject
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)receptionistWithNotificationName:(NSString*)name
                    postedFromNotificationCenter:(NSNotificationCenter*)notificationCenter
                                      fromObject:(id)object
                                  callbackWorker:(id<BBCSMPWorker>)worker
                                          target:(id)target
                                        selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
