//
//  BBCSMPAVPrerollCompleteEvent.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPAVPrerollCompleteEvent.h"

@implementation BBCSMPAVPrerollCompleteEvent

+ (instancetype)eventWithPrerollCompletionState:(BOOL)completionState
{
    return [[self alloc] initWithPrerollCompletionState:completionState];
}

- (instancetype)initWithPrerollCompletionState:(BOOL)completionState
{
    self = [super init];
    if (self) {
        _prerollDidCompleteSuccessfully = completionState;
    }
    
    return self;
}

@end
