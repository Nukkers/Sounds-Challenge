//
//  BBCOperationQueueWorker.m
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/05/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCOperationQueueWorker.h"
#import "BBCOperationQueueWorker+Internal.h"

#pragma mark -

@implementation BBCOperationQueueWorker

- (instancetype)init
{
    return [self initWithOperationQueue:[NSOperationQueue mainQueue]];
}

- (instancetype)initWithOperationQueue:(NSOperationQueue*)operationQueue
{
    self = [super init];
    if (self) {
        _operationQueue = operationQueue;
    }

    return self;
}

- (void)performWork:(BBCWork)work
{
    [self.operationQueue addOperationWithBlock:work];
}

@end
