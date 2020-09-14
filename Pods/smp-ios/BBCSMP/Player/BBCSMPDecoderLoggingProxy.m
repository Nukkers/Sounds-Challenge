//
//  BBCSMPDecoderLoggingProxy.m
//  SMP
//
//  Created by Thomas Sherwood on 09/02/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPDecoderLoggingProxy.h"
#import "BBCNSInvocationLogMessage.h"
#import "BBCSMPObjectLoggingProxy.h"
#import <SMP/SMP-Swift.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-property-synthesis"
#pragma clang diagnostic ignored "-Wprotocol"
@implementation BBCSMPDecoderLoggingProxy {
#pragma clang diagnostic pop
    NSObject<BBCSMPDecoder> *_decoder;
    BBCLogger *_log;
    BBCSMPObjectLoggingProxy *_delegateProxyToAvoidItBeingReleasedDueToWeakReferencing;
}

+ (instancetype)proxyForDecoder:(id<BBCSMPDecoder>)decoder
{
    return [[self alloc] initWithDecoder:decoder];
}

- (instancetype)initWithDecoder:(id<BBCSMPDecoder>)decoder
{
    _decoder = decoder;
    _log = [[BBCLoggingDomain smpDomain] loggerWithSubdomain:@"decoder-proxy"];
    
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_decoder methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    BBCNSInvocationLogMessage *message = [BBCNSInvocationLogMessage messageWithInvocation:invocation];
    [_log logMessage:message logLevel:BBCLogLevelDebug];
    
    if (invocation.selector == @selector(setDelegate:)) {
        [self extractDelegateFromInvocation:invocation proxiedOntoDecoder:(id)_decoder];
    }
    else {
        [invocation invokeWithTarget:_decoder];
    }
}

- (void)extractDelegateFromInvocation:(NSInvocation *)invocation
                   proxiedOntoDecoder:(id<BBCSMPDecoder>)decoder
{
    void *arg;
    [invocation getArgument:&arg atIndex:2];
    NSObject *delegate = (__bridge NSObject *)arg;
    
    BBCSMPObjectLoggingProxy *delegateProxy = [BBCSMPObjectLoggingProxy objectLoggingProxyForObject:delegate];
    _delegateProxyToAvoidItBeingReleasedDueToWeakReferencing = delegateProxy;
    _decoder.delegate = (id<BBCSMPDecoderDelegate>)delegateProxy;
}

@end
