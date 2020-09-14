//
//  BBCSMPOperationQueueWorker.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPOperationQueueWorker.h"

@implementation BBCSMPOperationQueueWorker {
    NSOperationQueue* _operationQueue;
}

#pragma mark Initialization

- (instancetype)init
{
    return self = [self initWithOperationQueue:[NSOperationQueue mainQueue]];
}

- (instancetype)initWithOperationQueue:(NSOperationQueue*)operationQueue
{
    self = [super init];
    if (self) {
        _operationQueue = operationQueue;
    }

    return self;
}

#pragma mark BBCSMPWorker

- (void)performWork:(BBCWork)work
{
    if ([self shouldPerformMainThreadWork]) {
        work();
    }
    else {
        [_operationQueue addOperation:[NSBlockOperation blockOperationWithBlock:work]];
    }
}

#pragma mark Private

- (BOOL)shouldPerformMainThreadWork
{
    NSThread *currentThread = [NSThread currentThread];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    return [currentThread isMainThread] && [mainQueue isEqual:_operationQueue];
}

@end
