//
//  BBCNSInvocationLogMessage.m
//  SMP
//
//  Created by Thomas Sherwood on 09/02/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCNSInvocationLogMessage.h"

@implementation BBCNSInvocationLogMessage {
    NSInvocation *_invocation;
}

+ (instancetype)messageWithInvocation:(NSInvocation *)invocation
{
    return [[self alloc] initWithInvocation:invocation];
}

- (instancetype)initWithInvocation:(NSInvocation *)invocation
{
    self = [super init];
    if (self) {
        _invocation = invocation;
    }
    
    return self;
}

- (NSString *)createLogMessage
{
    NSString *receieverString = NSStringFromClass([_invocation.target class]);
    NSString *selectorString = NSStringFromSelector([_invocation selector]);
    
    
    return [NSString stringWithFormat:@"- [%@ %@]", receieverString, selectorString];
}

@end
