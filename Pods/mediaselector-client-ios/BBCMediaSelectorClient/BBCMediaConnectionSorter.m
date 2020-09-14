//
//  BBCMediaConnectionSorter.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 23/01/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//
//  Based on BBCiPMediaSelectorSorter created by Matthew Price - POD Mobile Core Engineering on 01/08/2013.
//  Copyright (c) 2013 BBC. All rights reserved.
//

#import "BBCMediaConnection.h"
#import "BBCMediaConnectionSorter.h"

@interface BBCMediaConnection ()

@property (strong, nonatomic) NSNumber* dpw;
@property (strong, nonatomic) NSNumber* priority;

@end

@interface BBCMediaConnectionSorter ()

@property (strong, nonatomic) id<BBCMediaSelectorRandomization> randomization;

@end

@implementation BBCMediaConnectionSorter

- (instancetype)initWithRandomization:(id<BBCMediaSelectorRandomization>)randomization
{
    if ((self = [super init])) {
        self.randomization = randomization;
    }
    return self;
}

- (void)zeroUnsetDpwsAndPriorities:(NSArray*)connections
{
    for (BBCMediaConnection* connection in connections) {
        if (!connection.dpw) {
            connection.dpw = @0;
        }
        if (!connection.priority) {
            connection.priority = @0;
        }
    }
}

- (NSArray*)arrayByRemovingInvalidPriorities:(NSArray*)connections
{
    return [connections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"priority > %@ AND priority < %@", @0, @255]];
}

- (void)removeInvalidDpwValuesFromConnections:(NSArray*)connections
{
    // Any connections with a DPW greater than 100 should have their DPW set to 0
    NSArray* connectionsWithInvalidDPW = [connections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"dpw > %@", @100]];
    [connectionsWithInvalidDPW makeObjectsPerformSelector:@selector(setDpw:) withObject:@0];

    NSInteger totalDpw = [[connections valueForKeyPath:@"@sum.dpw"] integerValue];
    if (totalDpw > 100) {
        // If the total dpw is above 100 we need to clear all but the highest connection
        // (unless this itself is above 100, then in that case this should also be set to zero)
        NSInteger highestDpwValue = [[connections valueForKeyPath:@"@max.dpw"] integerValue];
        NSInteger lowestDpwValue = [[connections valueForKeyPath:@"@min.dpw"] integerValue];
        [connections enumerateObjectsUsingBlock:^(BBCMediaConnection* connection, NSUInteger index, BOOL* stop) {
            if ([connection.dpw integerValue] < highestDpwValue || lowestDpwValue == highestDpwValue) {
                connection.dpw = @0;
            }
        }];
    }
    else if (totalDpw < 100) {
        // If all connections have a dpw value and the total is less than 100 we need to remove all dpw values
        // as we cannot assign the remaining Dpw weighting anywhere.
        BOOL allConnectionsHaveDpw = ([connections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"dpw == %@", @0]].count == 0);
        if (allConnectionsHaveDpw) {
            [connections makeObjectsPerformSelector:@selector(setDpw:) withObject:@0];
        }
    }
}

- (void)addMissingDpwValuesToConnections:(NSArray*)connections
{
    NSInteger totalDpw = [[connections valueForKeyPath:@"@sum.dpw"] integerValue];
    if (totalDpw == 0) {
        return;
    }

    if (totalDpw < 100) {
        NSNumber* lowestPriorityValueWithoutDpw = [[connections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"dpw == %@", @0]] valueForKeyPath:@"@min.priority"];
        if ([lowestPriorityValueWithoutDpw integerValue] > 0) {
            NSArray* connectionsWithLowestPriorityValueAndNoDPW = [connections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"priority == %@ AND dpw == %@", lowestPriorityValueWithoutDpw, @0]];
            if (connectionsWithLowestPriorityValueAndNoDPW.count > 0) {
                __block NSInteger remainingDpw = 100 - totalDpw;
                float additionalDpwPerConnection = (float)remainingDpw / (float)connectionsWithLowestPriorityValueAndNoDPW.count;
                [connectionsWithLowestPriorityValueAndNoDPW enumerateObjectsUsingBlock:^(BBCMediaConnection* connection, NSUInteger idx, BOOL* stop) {
                    NSInteger additionalDpwForThisConnection = (remainingDpw - ceilf(additionalDpwPerConnection) >= 0) ? ceilf(additionalDpwPerConnection) : floorf(additionalDpwPerConnection);
                    connection.dpw = [NSNumber numberWithInteger:[connection.dpw integerValue] + additionalDpwForThisConnection];
                    remainingDpw -= additionalDpwForThisConnection;
                }];
            }
        }
    }
}

- (void)sortArrayByDpwAndPriority:(NSMutableArray*)connections
{
    NSSortDescriptor* dpwSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dpw" ascending:NO];
    NSSortDescriptor* prioritySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:YES];
    [connections sortUsingDescriptors:@[ dpwSortDescriptor, prioritySortDescriptor ]];
}

- (void)sortArrayBasedOnRandomDpwSelection:(NSMutableArray*)connections
{
    NSInteger percentage = [_randomization generateRandomPercentage];
    __block NSInteger dpwConsumed = 0;
    [connections enumerateObjectsUsingBlock:^(BBCMediaConnection* connection, NSUInteger index, BOOL* stop) {
        if ([connection.dpw integerValue] == 0) {
            *stop = YES;
        }
        dpwConsumed += [connection.dpw integerValue];
        if (percentage <= dpwConsumed) {
            BBCMediaConnection* selectedConnection = [connections objectAtIndex:index];
            [connections removeObjectAtIndex:index];
            [connections insertObject:selectedConnection atIndex:0];
            *stop = YES;
        }
    }];
}

- (NSArray*)normalizeAndSortMediaConnections:(NSArray*)connections
{
    [self zeroUnsetDpwsAndPriorities:connections];
    NSArray* sortedConnections = [self arrayByRemovingInvalidPriorities:connections];
    if (sortedConnections.count < 2) {
        return sortedConnections;
    }

    NSMutableDictionary* groupedConnections = [self groupConnectionsByTransferFormatWithConnections:sortedConnections];

    for (NSString* format in groupedConnections) {
        NSMutableArray* connectionsForFormat = groupedConnections[format];
        [self removeInvalidDpwValuesFromConnections:connectionsForFormat];
        if (connectionsForFormat.count > 1) {
            [self addMissingDpwValuesToConnections:connectionsForFormat];
        }

        [self sortArrayByDpwAndPriority:connectionsForFormat];
        [self sortArrayBasedOnRandomDpwSelection:connectionsForFormat];
    }

    sortedConnections = [self flattenGroupedConnections:groupedConnections];

    return sortedConnections;
}

- (NSMutableDictionary*)groupConnectionsByTransferFormatWithConnections:(NSArray*)sortedConnections
{
    NSMutableDictionary* groupedConnections = [NSMutableDictionary new];

    for (BBCMediaConnection* connection in sortedConnections) {
        NSString* format = connection.transferFormat;

        if (format == nil) {
            format = @"";
        }

        if ([groupedConnections objectForKey:format] == nil) {
            NSMutableArray* formatConnections = [[NSMutableArray alloc] init];
            [groupedConnections setObject:formatConnections forKey:format];
        }

        NSMutableArray* formatConnections = [groupedConnections objectForKey:format];
        [formatConnections addObject:connection];
    }

    return groupedConnections;
}

- (NSArray*)flattenGroupedConnections:(NSMutableDictionary*)groupedConnections
{
    NSMutableArray* flattenedArray = [NSMutableArray new];

    for (NSString* format in groupedConnections) {
        NSMutableArray* connectionsByFormat = groupedConnections[format];
        [flattenedArray addObjectsFromArray:connectionsByFormat];
    }

    return [flattenedArray copy];
}

@end
