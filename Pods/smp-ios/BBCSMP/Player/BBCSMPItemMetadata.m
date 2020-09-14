//
//  BBCSMPItemMetadata.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 24/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPItemMetadata.h"
#import "BBCSMPItemPreloadMetadata.h"

NSString* NSStringFromBBCSMPPIPSType(BBCSMPPIPSType pipsType)
{
    switch (pipsType) {
    case BBCSMPPIPSTypeEpisode:
        return @"Episode";
    }
}

NSString* NSStringFromBBCSMPAVType(BBCSMPAVType avType)
{
    switch (avType) {
    case BBCSMPAVTypeVideo:
        return @"Video";

    case BBCSMPAVTypeAudio:
        return @"Audio";
    }
}

NSString* NSStringFromBBCSMPMediaRetrievalType(BBCSMPMediaRetrievalType mediaRetrievalType)
{
    switch (mediaRetrievalType) {
    case BBCSMPMediaRetrievalTypeStream:
        return @"Stream";

    case BBCSMPMediaRetrievalTypeDownload:
        return @"Download";
    }
}

NSString* NSStringFromBBCSMPStreamType(BBCSMPStreamType streamType)
{
    switch (streamType) {
    case BBCSMPStreamTypeVOD:
        return @"VOD";

    case BBCSMPStreamTypeSimulcast:
        return @"Simulcast";

    case BBCSMPStreamTypeUnknown:
        return @"Unknown";
    }
}

@implementation BBCSMPItemMetadata

- (instancetype)initWithPreloadMetadata:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    if ((self = [super init])) {
        _preloadMetadata = preloadMetadata;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithPreloadMetadata:[[BBCSMPItemPreloadMetadata alloc] init]];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %@", [super description], [@{ @"pipsType" : NSStringFromBBCSMPPIPSType(_pipsType),
                                          @"avType" : NSStringFromBBCSMPAVType(_avType),
                                          @"mediaRetrievalType" : NSStringFromBBCSMPMediaRetrievalType(_mediaRetrievalType),
                                          @"streamType" : NSStringFromBBCSMPStreamType(_streamType),
                                          @"contentId" : _contentId ? _contentId : @"nil",
                                          @"versionId" : _versionId ? _versionId : @"nil",
                                          @"serviceId" : _serviceId ? _serviceId : @"nil",
                                          @"supplier" : _supplier ? _supplier : @"nil",
                                          @"transferFormat" : _transferFormat ? _transferFormat : @"nil",
                                          @"preloadMetdata" : _preloadMetadata ? _preloadMetadata : @"nil" } description]];
}

@end
