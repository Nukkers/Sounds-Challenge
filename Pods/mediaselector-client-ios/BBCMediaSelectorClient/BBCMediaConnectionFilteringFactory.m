//
//  BBCMediaConnectionFilteringFactory.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaConnectionFilteringFactory.h"
#import "BBCMediaPreferSecureConnectionFiltering.h"
#import "BBCMediaEnforceSecureConnectionFiltering.h"
#import "BBCMediaEnforceNonSecureConnectionFiltering.h"
#import "BBCMediaNoPreferenceConnectionFiltering.h"

@implementation BBCMediaConnectionFilteringFactory

+ (id<BBCMediaConnectionFiltering>)filteringForFilter:(BBCMediaConnectionFilter*)filter
                       withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)preference
{
    switch (preference) {
        case BBCMediaSelectorSecureConnectionPreferSecure: {
            return [[BBCMediaPreferSecureConnectionFiltering alloc] initWithFilter:filter];
        }
        case BBCMediaSelectorSecureConnectionEnforceSecure: {
            return [[BBCMediaEnforceSecureConnectionFiltering alloc] initWithFilter:filter];
        }
        case BBCMediaSelectorSecureConnectionEnforceNonSecure: {
            return [[BBCMediaEnforceNonSecureConnectionFiltering alloc] initWithFilter:filter];
        }
        case BBCMediaSelectorSecureConnectionUseServerResponse: {
            return [[BBCMediaNoPreferenceConnectionFiltering alloc] initWithFilter:filter];
        }
    }
}

@end
