//
//  BBCSMPInternalErrorEvent.h
//  BBCSMP
//
//  Created by Ryan Johnstone on 08/05/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCSMPError.h"

@interface BBCSMPInternalErrorEvent : NSObject

@property (nonatomic, strong) BBCSMPError* smpError;

@end
