//
//  BBCMediaConnectionFilteringPredicateBuilder.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 28/09/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaConnectionFilteringPredicateBuilder.h"

@implementation BBCMediaConnectionFilteringPredicateBuilder

+ (NSPredicate*)predicateForConnectionFilter:(BBCMediaConnectionFilter*)connectionFilter
{
    NSMutableArray<NSPredicate*>* subpredicates = [NSMutableArray array];
    for (NSString* filterName in connectionFilter.requiredFilters.allKeys) {
        NSSet* filterValues = connectionFilter.requiredFilters[filterName];
        if (filterValues) {
            NSPredicate* subpredicate = [NSPredicate predicateWithFormat:@"%K IN %@" argumentArray:@[filterName, filterValues]];
            [subpredicates addObject:subpredicate];
        }
    }
    return [NSCompoundPredicate andPredicateWithSubpredicates:subpredicates];
}

+ (NSPredicate*)predicateForConnectionFilter:(BBCMediaConnectionFilter*)connectionFilter withSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference
{
    BBCMediaConnectionFilter* baseFilter = connectionFilter ? [BBCMediaConnectionFilter filterWithFilter:connectionFilter] : [BBCMediaConnectionFilter filter];
    BBCMediaConnectionFilter* filterWithPreference = baseFilter;
    switch (secureConnectionPreference) {
        case BBCMediaSelectorSecureConnectionEnforceSecure: {
            filterWithPreference = [baseFilter withRequiredProtocols:@[@"https"]];
            break;
        }
        case BBCMediaSelectorSecureConnectionEnforceNonSecure: {
            filterWithPreference = [baseFilter withRequiredProtocols:@[@"http"]];
            break;
        }
        case BBCMediaSelectorSecureConnectionUseServerResponse: {
            break;
        }
        case BBCMediaSelectorSecureConnectionPreferSecure: {
            NSAssert(NO, @"BBCMediaSelectorSecureConnectionPreferSecure is not a valid secureConnectionPreference to pass to predicateForConnectionFilter");
            break;
        }
    }
    return [[self class] predicateForConnectionFilter:filterWithPreference];
}

@end
