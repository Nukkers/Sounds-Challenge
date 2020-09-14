//
//  BBCSMPAVCriticalErrorEvent.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVCriticalErrorEvent.h"
#import "BBCSMPAVErrors.h"

@implementation BBCSMPAVCriticalErrorEvent

+ (instancetype)event
{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Player failed to play to the end of the content."};
    NSError *error = [NSError errorWithDomain:BBCSMPAVDecoderErrorDomain code:0 userInfo:userInfo];
    return [[self alloc] initWithError:error];
}

+ (instancetype)eventWithError:(NSError *)error
{
    return [[self alloc] initWithError:error];
}

- (instancetype)initWithError:(NSError *)error
{
    self = [super init];
    if(self) {
        _error = error;
    }
    
    return self;
}

@end
