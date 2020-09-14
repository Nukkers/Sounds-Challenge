//
//  BBCSMPTelemetryLastRequestedItemTracker.m
//  Pods
//
//  Created by Ryan Johnstone on 29/06/2017.
//
//

#import "BBCSMPTelemetryLastRequestedItemTracker.h"
#import "BBCSMPItemPreloadMetadataUpdatedEvent.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPItemLoadedEvent.h"
#import "BBCSMPItemProviderUpdatedEvent.h"
#import "BBCSMPItem.h"
#import "BBCSMPEventBus.h"

@implementation BBCSMPTelemetryLastRequestedItemTracker {
    BBCSMPItemPreloadMetadata *_preloadMetadata;
    BBCSMPItemMetadata *_metaData;
}

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus {
    
    self = [super init];
    
    if (self) {
        [eventBus addTarget:self
               selector:@selector(handlePreloadMetadataUpdatedEvent:)
           forEventType:[BBCSMPItemPreloadMetadataUpdatedEvent class]];
        
        [eventBus addTarget:self
                   selector:@selector(handleItemLoadedEvent:)
               forEventType:[BBCSMPItemLoadedEvent class]];
        
        [eventBus addTarget:self
                   selector:@selector(handleItemProviderUpdatedEvent)
               forEventType:[BBCSMPItemProviderUpdatedEvent class]];
    }
    
    return self;
}

- (void)handlePreloadMetadataUpdatedEvent:(BBCSMPItemPreloadMetadataUpdatedEvent *)preloadMetadataUpdatedEvent
{
    _preloadMetadata = preloadMetadataUpdatedEvent.preloadMetadata;
}

- (void)handleItemLoadedEvent:(BBCSMPItemLoadedEvent *)event
{
    _preloadMetadata = event.item.metadata.preloadMetadata;
    _metaData = event.item.metadata;
}

- (void)handleItemProviderUpdatedEvent
{
    _preloadMetadata = nil;
}

- (NSString *)vpidForCurrentItem
{
    if ([self isSimulcastItem]) {
        return _preloadMetadata.partialMetadata.serviceId;
    }
    else {
        return _preloadMetadata.partialMetadata.versionId;
    }
}

- (BBCSMPAVType)avType {
    return _preloadMetadata.partialMetadata.avType;
}

- (BBCSMPStreamType)streamType {
    return _preloadMetadata.partialMetadata.streamType;
}

- (NSString *)supplier {
    return _metaData.supplier;
}

- (NSString *)transferFormat {
    return _metaData.transferFormat;
}

- (NSString *)libraryName {
    return _preloadMetadata.decoderName;
}

- (NSString *)libraryVersion {
    return _preloadMetadata.decoderVersion;
}

#pragma mark private

- (BOOL)isSimulcastItem
{
    return _preloadMetadata.partialMetadata.streamType == BBCSMPStreamTypeSimulcast;
}

@end
