//
//  BBCMediaEnforceNonSecureConnectionFiltering.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaEnforceNonSecureConnectionFiltering.h"
#import "BBCMediaConnectionFilteringPredicateBuilder.h"

@interface BBCMediaEnforceNonSecureConnectionFiltering ()

@property (strong,nonatomic) BBCMediaConnectionFilter* filter;

@end

@implementation BBCMediaEnforceNonSecureConnectionFiltering

- (instancetype)initWithFilter:(BBCMediaConnectionFilter*)filter
{
    if ((self = [super init])) {
        _filter = filter;
    }
    return self;
}

- (NSArray<BBCMediaConnection*>*)filterConnections:(NSArray<BBCMediaConnection*>*)connections
{
    return [connections filteredArrayUsingPredicate:[BBCMediaConnectionFilteringPredicateBuilder predicateForConnectionFilter:_filter withSecureConnectionPreference:BBCMediaSelectorSecureConnectionEnforceNonSecure]];
}

@end
