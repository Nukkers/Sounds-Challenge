//
//  BBCHTTPOperationQueueWorker.m
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCHTTPOperationQueueWorker.h"

@implementation BBCHTTPOperationQueueWorker

#pragma mark Initialization

- (instancetype)init
{
    return [self initWithOperationQueue:NSOperationQueue.mainQueue];
}

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue
{
    self = [super init];
    if(self) {
        _operationQueue = operationQueue;
    }
    
    return self;
}

#pragma mark BBCHTTPResponseWorker

- (void)perform:(void(^)(void))work
{
    [_operationQueue addOperationWithBlock:work];
}

@end
