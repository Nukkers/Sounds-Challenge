//
//  BBCHTTPConsoleLogger.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPConsoleLogger.h"

@implementation BBCHTTPConsoleLogger

- (void)logString:(NSString*)string
{
    NSLog(@"%@", string);
}

@end
