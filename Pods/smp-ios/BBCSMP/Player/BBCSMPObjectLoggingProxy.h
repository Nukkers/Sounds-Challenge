//
//  BBCSMPObjectLoggingProxy.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@interface BBCSMPObjectLoggingProxy : NSProxy
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)objectLoggingProxyForObject:(NSObject *)obj;

@end
