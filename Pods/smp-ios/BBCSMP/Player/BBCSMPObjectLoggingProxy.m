//
//  BBCSMPDecoderDelegateLoggingProxy.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 23/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPObjectLoggingProxy.h"
#import "BBCNSInvocationLogMessage.h"
#import <SMP/SMP-Swift.h>

@implementation BBCSMPObjectLoggingProxy {
    NSObject *_obj;
    BBCLogger *_log;
}

+ (instancetype)objectLoggingProxyForObject:(NSObject *)obj
{
    return [[BBCSMPObjectLoggingProxy alloc] initWithObject:obj];
}

- (instancetype)initWithObject:(NSObject *)obj
{
    _obj = obj;
    
    NSString *objectClass = NSStringFromClass([obj class]);
    NSString *subdomain = [NSString stringWithFormat:@"proxy.%@", objectClass];
    _log = [[BBCLoggingDomain smpDomain] loggerWithSubdomain:subdomain];
    
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [_obj respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [_obj methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    BBCNSInvocationLogMessage *message = [BBCNSInvocationLogMessage messageWithInvocation:invocation];
    [_log logMessage:message logLevel:BBCLogLevelDebug];
    [invocation invokeWithTarget:_obj];
}

@end
