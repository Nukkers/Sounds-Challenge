//
//  BBCHTTPConsoleLoggingNetworkObserver.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPConsoleLogger.h"
#import "BBCHTTPConsoleLoggingNetworkObserver.h"

@implementation BBCHTTPConsoleLoggingNetworkObserver

- (instancetype)init
{
    self = [super initWithLogger:[[BBCHTTPConsoleLogger alloc] init]];
    return self;
}

@end
