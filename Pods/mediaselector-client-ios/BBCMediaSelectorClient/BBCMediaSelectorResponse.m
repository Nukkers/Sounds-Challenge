//
//  BBCMediaSelectorResponse.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaSelectorResponse.h"

@interface BBCMediaSelectorResponse ()

@property (strong,nonatomic) NSArray *items;

@end

@implementation BBCMediaSelectorResponse

- (instancetype)init
{
    if ((self = [super init])) {
        self.items = @[];
    }
    return self;
}

- (instancetype)initWithMediaArray:(NSArray *)mediaArray connectionSorting:(id<BBCMediaConnectionSorting>)connectionSorting numberFormatter:(NSNumberFormatter *)numberFormatter dateFormatter:(NSDateFormatter *)dateFormatter
{
    if ((self = [super init])) {
        NSMutableArray *mutableItems = [NSMutableArray arrayWithCapacity:mediaArray.count];
        for (NSDictionary *mediaItemDictionary in mediaArray) {
            BBCMediaItem *item = [[BBCMediaItem alloc] initWithDictionary:mediaItemDictionary connectionSorting:connectionSorting numberFormatter:numberFormatter dateFormatter:dateFormatter];
            [mutableItems addObject:item];
        }
        self.items = [NSArray arrayWithArray:mutableItems];
    }
    return self;
}

- (void)setSecureConnectionPreference:(BBCMediaSelectorSecureConnectionPreference)secureConnectionPreference
{
    for (BBCMediaItem* item in _items) {
        [item setSecureConnectionPreference:secureConnectionPreference];
    }
}

- (NSArray *)availableBitrates
{
    return [[[_items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"kind == %@ OR kind == %@",@"video",@"audio"]] valueForKeyPath:@"bitrate"] sortedArrayUsingSelector:@selector(compare:)];
}

- (BBCMediaItem *)itemForBitrate:(NSNumber *)bitrate
{
    return [[_items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(kind == %@ OR kind == %@) AND bitrate == %@",@"video",@"audio",bitrate]] firstObject];
}

- (BBCMediaItem *)itemForHighestBitrate
{
    return [self itemForBitrate:[[self availableBitrates] lastObject]];
}

- (BBCMediaItem *)itemForCaptions
{
    return [[_items filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"kind == %@",@"captions"]] firstObject];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n%@",[super description],[_items description]];
}

@end
