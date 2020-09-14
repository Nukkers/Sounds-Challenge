//
//  BBCHTTPFileLoggingNetworkObserver.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPFileLogger.h"
#import "BBCHTTPFileLoggingNetworkObserver.h"

@implementation BBCHTTPFileLoggingNetworkObserver

- (instancetype)initWithLogFilePath:(NSString*)logFilePath
{
    self = [super initWithLogger:[[BBCHTTPFileLogger alloc] initWithLogFilePath:logFilePath]];
    return self;
}

@end
