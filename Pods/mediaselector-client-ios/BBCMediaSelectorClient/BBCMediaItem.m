//
//  BBCMediaItem.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaItem.h"
#import "BBCMediaConnectionSorter.h"
#import "BBCMediaConnectionFilteringFactory.h"

@interface BBCMediaItem ()

@property (strong,nonatomic) NSString *kind;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *encoding;
@property (strong,nonatomic) NSNumber *bitrate;
@property (strong,nonatomic) NSNumber *width;
@property (strong,nonatomic) NSNumber *height;
@property (strong,nonatomic) NSString *service;
@property (strong,nonatomic) NSArray<BBCMediaConnection*> *unsortedConnections;
@property (strong,nonatomic) NSArray<BBCMediaConnection*> *filteredAndSortedConnections;
@property (strong,nonatomic) NSDate *expires;
@property (strong,nonatomic) NSNumber *mediaFileSize;

@property (weak,nonatomic) NSNumberFormatter *numberFormatter;
@property (weak,nonatomic) NSDateFormatter *dateFormatter;

@property (strong,nonatomic) BBCMediaConnectionFilter* connectionFilter;
@property (nonatomic) BBCMediaSelectorSecureConnectionPreference secureConnectionPreference;

@property (strong,nonatomic) id<BBCMediaConnectionSorting> connectionSorting;
@property (strong,nonatomic) id<BBCMediaConnectionFiltering> connectionFiltering;

@end

@implementation BBCMediaItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                 connectionSorting:(id<BBCMediaConnectionSorting>)connectionSorting
                   numberFormatter:(NSNumberFormatter *)numberFormatter
                     dateFormatter:(NSDateFormatter *)dateFormatter
{
    if ((self = [super init])) {
        self.connectionSorting = connectionSorting;
        self.secureConnectionPreference = BBCMediaSelectorSecureConnectionUseServerResponse;
        self.numberFormatter = numberFormatter;
        self.dateFormatter = dateFormatter;
        [self setValuesForKeysWithDictionary:dictionary];
        self.numberFormatter = nil;
        self.dateFormatter = nil;
    }
    return self;
}

- (NSArray<BBCMediaConnection*>*)connections
{
    if (!_filteredAndSortedConnections) {
        self.filteredAndSortedConnections = [self sortConnections:[self filterConnections:_unsortedConnections]];
    }
    return _filteredAndSortedConnections;
}

- (NSArray<BBCMediaConnection*>*)filterConnections:(NSArray<BBCMediaConnection*>*)connections
{
    return _connectionFiltering ? [_connectionFiltering filterConnections:connections] : connections;
}

- (NSArray<BBCMediaConnection*>*)sortConnections:(NSArray<BBCMediaConnection*>*)connections
{
    return _connectionSorting ? [_connectionSorting normalizeAndSortMediaConnections:connections] : connections;
}

- (void)setConnectionFilter:(BBCMediaConnectionFilter*)connectionFilter
{
    if (_connectionFilter == connectionFilter)
        return;
    
    _connectionFilter = connectionFilter;
    self.connectionFiltering = [BBCMediaConnectionFilteringFactory filteringForFilter:_connectionFilter withSecureConnectionPreference:_secureConnectionPreference];
}

- (void)setSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference
{
    if (_secureConnectionPreference == secureConnectionPreference)
        return;
    
    _secureConnectionPreference = secureConnectionPreference;
    self.connectionFiltering = [BBCMediaConnectionFilteringFactory filteringForFilter:_connectionFilter withSecureConnectionPreference:_secureConnectionPreference];
}

- (void)setConnectionSorting:(id<BBCMediaConnectionSorting>)connectionSorting
{
    if (_connectionSorting == connectionSorting)
        return;
    
    _connectionSorting = connectionSorting;
    self.filteredAndSortedConnections = nil;
}

- (void)setConnectionFiltering:(id<BBCMediaConnectionFiltering>)connectionFiltering
{
    if (_connectionFiltering == connectionFiltering)
        return;
    
    _connectionFiltering = connectionFiltering;
    self.filteredAndSortedConnections = nil;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"connection"] && [value isKindOfClass:[NSArray class]]) {
        NSArray *connectionDictionaries = value;
        NSMutableArray *mutableConnections = [NSMutableArray arrayWithCapacity:connectionDictionaries.count];
        for (NSDictionary *connectionDictionary in connectionDictionaries) {
            BBCMediaConnection *connection = [[BBCMediaConnection alloc] initWithDictionary:connectionDictionary numberFormatter:_numberFormatter dateFormatter:_dateFormatter];
            [mutableConnections addObject:connection];
        }
        self.unsortedConnections = mutableConnections;
    } else if ([key isEqualToString:@"width"] && [value isKindOfClass:[NSString class]]) {
        self.width = [_numberFormatter numberFromString:value];
    } else if ([key isEqualToString:@"height"] && [value isKindOfClass:[NSString class]]) {
        self.height = [_numberFormatter numberFromString:value];
    } else if ([key isEqualToString:@"bitrate"] && [value isKindOfClass:[NSString class]]) {
        self.bitrate = [_numberFormatter numberFromString:value];
    } else if ([key isEqualToString:@"media_file_size"] && [value isKindOfClass:[NSString class]]) {
        self.mediaFileSize = [_numberFormatter numberFromString:value];
    } else if ([key isEqualToString:@"expires"] && [value isKindOfClass:[NSString class]]) {
        self.expires = [_dateFormatter dateFromString:value];
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"BBCMediaSelection: Undefined key - %@ : %@",key,value);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n  Kind:%@; Type:%@; Bitrate:%@kbps; Width:%@; Height:%@; Connections:\n%@",[super description],_kind,_type,_bitrate,_width,_height,[self.connections description]];
}

@end
