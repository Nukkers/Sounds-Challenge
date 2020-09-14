//
//  BBCSMPUniversalLogWriter.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUniversalLogWriter.h"
#import <os/log.h>

@implementation BBCSMPUniversalLogWriter {
    os_log_t _log;
}

#pragma mark Initialization

- (instancetype)initWithDomain:(NSString *)domain subdomain:(NSString *)subdomain
{
    self = [super init];
    if (self) {
        _log = os_log_create([domain UTF8String], [subdomain UTF8String]);
    }
    
    return self;
}

#pragma mark BBCSMPLog

- (BOOL)isDebugLoggingEnabled
{
    return os_log_debug_enabled(_log);
}

- (void)logDebugMessage:(NSString *)message
{
    os_log_debug(_log, "%{public}@", message);
}

- (void)logErrorMessage:(NSString *)message
{
    os_log_error(_log, "%{public}@", message);
}

- (void)logMessage:(NSString *)message
{
    os_log(_log, "%{public}@", message);
}

@end
