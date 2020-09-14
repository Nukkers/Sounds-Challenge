//
//  BBCMediaEnforceSecureConnectionFiltering.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 03/10/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaEnforceSecureConnectionFiltering.h"
#import "BBCMediaConnectionFilteringPredicateBuilder.h"

@interface BBCMediaEnforceSecureConnectionFiltering ()

@property (strong,nonatomic) BBCMediaConnectionFilter* filter;

@end

@implementation BBCMediaEnforceSecureConnectionFiltering

- (instancetype)initWithFilter:(BBCMediaConnectionFilter*)filter
{
    if ((self = [super init])) {
        _filter = filter;
    }
    return self;
}

- (NSArray<BBCMediaConnection*>*)filterConnections:(NSArray<BBCMediaConnection*>*)connections
{
    return [connections filteredArrayUsingPredicate:[BBCMediaConnectionFilteringPredicateBuilder predicateForConnectionFilter:_filter withSecureConnectionPreference:BBCMediaSelectorSecureConnectionEnforceSecure]];
}

@end
