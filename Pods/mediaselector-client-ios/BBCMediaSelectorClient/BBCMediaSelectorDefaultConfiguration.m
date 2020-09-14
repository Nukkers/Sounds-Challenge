//
//  BBCMediaSelectorDefaultConfiguration.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 22/01/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaSelectorDefaultConfiguration.h"

@implementation BBCMediaSelectorDefaultConfiguration

- (NSString*)mediaSelectorBaseURL
{
    return @"https://open.live.bbc.co.uk/mediaselector/6/select/";
}

- (NSString*)secureMediaSelectorBaseURL
{
    return @"https://av-media-sslgate.live.bbc.co.uk/saml/mediaselector/6/select/";
}

- (NSArray*)defaultParameters
{
    return @[ [[BBCMediaSelectorRequestParameter alloc] initWithName:@"version" value:@"2.0"], [[BBCMediaSelectorRequestParameter alloc] initWithName:@"format" value:@"json"] ];
}

- (NSString*)mediaSet
{
    return @"mobile-phone-main";
}

@end
