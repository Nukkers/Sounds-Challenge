//
//  BBCSMPDefines.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 12/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef BBC_SMP_MACROS
#define BBC_SMP_MACROS

#define BBC_SMP_DEPRECATED(msg) __attribute__((deprecated(msg)))
#define BBC_SMP_INIT_UNAVAILABLE - (instancetype)init NS_UNAVAILABLE;

#endif
