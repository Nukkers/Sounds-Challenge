//
//  BBCHTTPLoggingNetworkObserver.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPLoggingNetworkObserver.h"

@interface BBCHTTPLoggingNetworkObserver ()

@property (strong, nonatomic) id<BBCHTTPLogger> logger;

@end

#pragma mark -

@implementation BBCHTTPLoggingNetworkObserver

- (instancetype)initWithLogger:(id<BBCHTTPLogger>)logger
{
    if ((self = [super init])) {
        _logger = logger;
    }

    return self;
}

#pragma mark - BBCHTTPNetworkObserver

- (void)willSendRequest:(NSURLRequest*)request
{
    if (!request) {
        return;
    }
    
    [_logger logString:request.description];
}

- (void)didReceiveNetworkError:(NSError*)error
{
    if (!error) {
        return;
    }
    
    [_logger logString:error.description];
}

- (void)didReceiveResponse:(NSHTTPURLResponse*)response
{
    if (!response) {
        return;
    }
    
    [_logger logString:response.description];
}

@end
