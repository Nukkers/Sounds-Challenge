//
//  BBCHTTPFileLogger.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPFileLogger.h"

@interface BBCHTTPFileLogger ()

@property (strong, nonatomic) NSFileHandle* logFileHandle;

@end

#pragma mark -

@implementation BBCHTTPFileLogger

- (instancetype)initWithLogFilePath:(NSString*)logFilePath
{
    if ((self = [super init])) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSString* logFileDirectory = logFilePath.stringByDeletingLastPathComponent;
        if (![fileManager fileExistsAtPath:logFileDirectory]) {
            NSError* error = nil;
            if (![fileManager createDirectoryAtPath:logFileDirectory withIntermediateDirectories:YES attributes:nil error:&error]) {
                NSLog(@"Error creating log directory: %@", error);
            }
        }
        if (![fileManager fileExistsAtPath:logFilePath]) {
            [fileManager createFileAtPath:logFilePath contents:[NSData data] attributes:nil];
        }
        _logFileHandle = [NSFileHandle fileHandleForUpdatingAtPath:logFilePath];
        [_logFileHandle seekToEndOfFile];
    }

    return self;
}

- (void)dealloc
{
    [_logFileHandle closeFile];
}

- (void)logString:(NSString*)string
{
    NSData* logData = [[string stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding];
    [_logFileHandle writeData:logData];
}

@end
