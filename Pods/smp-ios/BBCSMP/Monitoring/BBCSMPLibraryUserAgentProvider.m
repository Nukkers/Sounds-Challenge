//
//  BBCSMPLibraryUserAgentProvider.m
//  BBCSMP
//
//  Created by Al Priest on 03/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import <HTTPClient/BBCHTTPLibraryUserAgent.h>
#import "BBCSMPLibraryUserAgentProvider.h"
#import "BBCSMPVersion.h"

@implementation BBCSMPLibraryUserAgentProvider

- (NSString*)userAgent
{
    BBCHTTPLibraryUserAgent* libraryUserAgent = [BBCHTTPLibraryUserAgent userAgentWithLibraryName:@"smpiOS" libraryVersion:@BBC_SMP_VERSION];
    return [libraryUserAgent userAgent];
}

@end
