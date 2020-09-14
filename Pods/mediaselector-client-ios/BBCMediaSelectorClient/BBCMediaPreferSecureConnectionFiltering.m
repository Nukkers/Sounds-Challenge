//
//  BBCMediaPreferSecureConnectionFiltering.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaPreferSecureConnectionFiltering.h"
#import "BBCMediaConnectionFilteringPredicateBuilder.h"

@interface BBCMediaPreferSecureConnectionFiltering ()

@property (strong,nonatomic) BBCMediaConnectionFilter* filter;

@end

@implementation BBCMediaPreferSecureConnectionFiltering

- (instancetype)initWithFilter:(BBCMediaConnectionFilter*)filter
{
    if ((self = [super init])) {
        _filter = filter;
    }
    return self;
}

- (NSArray<BBCMediaConnection*>*)filterConnections:(NSArray<BBCMediaConnection*>*)connections
{
    // Try to get https connections
    NSArray<BBCMediaConnection*>* filteredConnections = [connections filteredArrayUsingPredicate:[BBCMediaConnectionFilteringPredicateBuilder predicateForConnectionFilter:_filter withSecureConnectionPreference:BBCMediaSelectorSecureConnectionEnforceSecure]];
    if (filteredConnections.count > 0) {
        return filteredConnections;
    } else {
        // Get http connections if we didn't get any https connections
        return [connections filteredArrayUsingPredicate:[BBCMediaConnectionFilteringPredicateBuilder predicateForConnectionFilter:_filter withSecureConnectionPreference:BBCMediaSelectorSecureConnectionEnforceNonSecure]];
    }
}

@end
