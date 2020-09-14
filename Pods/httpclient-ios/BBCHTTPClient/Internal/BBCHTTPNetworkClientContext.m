//
//  BBCHTTPNetworkClientContext.m
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCHTTPNetworkClientContext.h"
#import "BBCHTTPOperationQueueWorker.h"

@implementation BBCHTTPNetworkClientContext

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if(self) {
        _responseWorker = [BBCHTTPOperationQueueWorker new];
        _acceptableStatusCodeRange = NSMakeRange(200, 100);
        _taskRegistry = [BBCHTTPNetworkTaskRegistry new];
    }
    
    return self;
}

@end
