//
//  BBCSMPItemPreloadMetadata.m
//  BBCSMP
//
//  Created by Thomas Sherwood on 17/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPArtworkFetcher.h"
#import "BBCSMPArtworkURLProvider.h"
#import "BBCSMPDuration.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPItemPreloadMetadata.h"

@interface BBCSMPItemPreloadMetadata ()

@property (nonatomic, strong) BBCSMPItemMetadata* partialMetadata;

@end

@implementation BBCSMPItemPreloadMetadata

#pragma mark Overrides

- (instancetype)init
{
    if ((self = [super init])) {
        _partialMetadata = [[BBCSMPItemMetadata alloc] initWithPreloadMetadata:nil];
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %@", [super description], [@{ @"title" : _title ? _title : @"nil",
                                          @"subtitle" : _subtitle ? _subtitle : @"nil",
                                          @"guidanceMessage" : _guidanceMessage ? _guidanceMessage : @"nil",
                                          @"duration" : _duration ? _duration : @"nil",
                                          @"artworkFetcher" : _artworkFetcher ? [_artworkFetcher description] : @"nil",
                                          @"partialMetadata" : _partialMetadata ? [_partialMetadata description] : @"nil",
                                          @"customAvStatsLabels" : _customAvStatsLabels ? [_customAvStatsLabels description] : @"nil"
                                      } description]];
}

- (BOOL)isEqual:(id)object
{
    BBCSMPItemPreloadMetadata* metadata = (BBCSMPItemPreloadMetadata*)object;
    if (![metadata isKindOfClass:[BBCSMPItemPreloadMetadata class]]) {
        return NO;
    }
    
    BOOL artworkProviderComparisonResult = NO;
    if (_artworkFetcher && metadata.artworkFetcher) {
        artworkProviderComparisonResult = [self.artworkFetcher isEqual:metadata.artworkFetcher];
    }
    else if (!_artworkFetcher && !metadata.artworkFetcher) {
        artworkProviderComparisonResult = YES;
    }

    return [self.title isEqualToString:metadata.title] &&
        [self.subtitle isEqualToString:metadata.subtitle] &&
        [self.guidanceMessage isEqualToString:metadata.guidanceMessage] &&
        [self.duration isEqual:metadata.duration] &&
        [_customAvStatsLabels isEqualToDictionary:metadata.customAvStatsLabels] &&
        artworkProviderComparisonResult;
}

@end
