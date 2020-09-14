//
//  BBCSMPBackgroundManagerNotificationAdapter.h
//  BBCSMP
//
//  Created by James Shephard on 16/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPBackgroundStateProvider.h"

@interface BBCSMPBackgroundManagerNotificationAdapter : NSObject <BBCSMPBackgroundStateProvider>

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter NS_DESIGNATED_INITIALIZER;

@end
