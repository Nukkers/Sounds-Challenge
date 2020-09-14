//
//  BBCSMPMediaSelectorPlayerItemProvider.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <MediaSelector/BBCMediaSelectorClient.h>
#import <MediaSelector/BBCMediaSelectorSecureConnectionPreference.h>
#import "BBCSMPBackingOffMediaSelectorPlayerItemProvider.h"
#import "BBCSMPItemPreloadMetadata.h"
#import "BBCSMPMediaSelectorItem.h"
#import "BBCSMPNetworkArtworkFetcher.h"
#import "BBCSMPItemMetadata.h"
#import "BBCSMPMediaURLBlacklist.h"
#import "BBCSMPMediaSelectionLogMessage.h"
#import "BBCSMPMediaSelectorConnectionResolver.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPBackingOffMediaSelectorPlayerItemProvider ()

@property (nonatomic, strong) BBCMediaSelectorClient* mediaSelectorClient;
@property (nonatomic, strong) NSString* mediaSet;
@property (nonatomic, strong) NSString* vpid;
@property (nonatomic, strong) NSArray<NSString*>* transferFormats;
@property (nonatomic, strong) BBCMediaSelectorResponse* mediaSelectorResponse;
@property (nonatomic, strong, readonly) BBCMediaItem* selectedItem;
@property (nonatomic, strong, readonly) NSArray* connections;
@property (nonatomic, strong, readonly) BBCMediaConnection* currentConnection;
@property (nonatomic, assign) NSUInteger currentConnectionIndex;

@end

@implementation BBCSMPBackingOffMediaSelectorPlayerItemProvider {
    id<BBCSMPMediaURLBlacklist> _blacklist;
    id<BBCSMPMediaSelectorConnectionResolver> _connectionResolver;
}

+ (BBCLogger *)logger
{
    static BBCLogger *logger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[BBCLoggingDomain smpDomain] loggerWithSubdomain:@"media-selector"];
    });
    
    return logger;
}

+ (NSDictionary*) supplierDictionary
{
    NSDictionary* mediaSelectorSupplierDictionaries = @{
                                                        @"Akamai" : @[@"akamai",
                                                                      @"akamai_dash_live",
                                                                      @"akamai_freesat",
                                                                      @"akamai_hd",
                                                                      @"akamai_hds",
                                                                      @"akamai_hds_vod",
                                                                      @"akamai_hls",
                                                                      @"akamai_hls_live",
                                                                      @"akamai_hls_open",
                                                                      @"akamai_hls_secure",
                                                                      @"akamai_http",
                                                                      @"akamai_http_failover",
                                                                      @"akamai_https_failover",
                                                                      @"akamai_news_hls_closed",
                                                                      @"akamai_news_hls_open",
                                                                      @"akamai_news_http",
                                                                      @"akamai_ns",
                                                                      @"akamai_wii",
                                                                      @"mf_akamai_uk_dash",
                                                                      @"mf_akamai_uk_hds",
                                                                      @"mf_akamai_uk_hls",
                                                                      @"mf_akamai_uk_plain",
                                                                      @"mf_akamai_uk_plain_longtok",
                                                                      @"mf_akamai_uk_plain_sec",
                                                                      @"mf_akamai_uk_smooth_notok",
                                                                      @"mf_akamai_world_dash",
                                                                      @"mf_akamai_world_hds",
                                                                      @"mf_akamai_world_hls",
                                                                      @"mf_akamai_world_plain"],
                                                        @"Bidi" : @[@"bidi_hls",
                                                                    @"bidi_hls_open",
                                                                    @"mf_bidi_uk_dash",
                                                                    @"mf_bidi_uk_hds",
                                                                    @"mf_bidi_uk_hls",
                                                                    @"mf_bidi_uk_hls_https"],
                                                        @"LimeLight" : @[@"limelight",
                                                                         @"limelight_hds",
                                                                         @"limelight_news_http",
                                                                         @"limelight_ns",
                                                                         @"mf_limelight_uk_dash",
                                                                         @"mf_limelight_uk_hds",
                                                                         @"mf_limelight_uk_hls",
                                                                         @"mf_limelight_uk_plain",
                                                                         @"mf_limelight_uk_plain_longtok",
                                                                         @"mf_limelight_uk_plain_sec",
                                                                         @"mf_limelight_uk_smooth_notok",
                                                                         @"mf_limelight_world_dash",
                                                                         @"mf_limelight_world_hds",
                                                                         @"mf_limelight_world_hls",
                                                                         @"mf_limelight_world_plain",
                                                                         @"mf_limelight_uk_hls_https"],
                                                        };
    return mediaSelectorSupplierDictionaries;
}

- (instancetype)initWithMediaSelectorClient:(BBCMediaSelectorClient*)mediaSelectorClient
                                   mediaSet:(NSString*)mediaSet
                                       vpid:(NSString*)vpid
                             artworkFetcher:(id<BBCSMPArtworkFetcher>)artworkFetcher
                                  blacklist:(id<BBCSMPMediaURLBlacklist>)blacklist
                         connectionResolver:(id<BBCSMPMediaSelectorConnectionResolver>) connectionResolver
                       avStatisticsConsumer:(id<BBCSMPAVStatisticsConsumer>) avStatisticsConsumer
{
    if ((self = [super init])) {
        self.artworkFetcher = artworkFetcher;
        self.mediaSelectorClient = mediaSelectorClient;
        self.mediaSet = mediaSet;
        self.vpid = vpid;
        self.transferFormats = @[ @"hls" ];
        self.playOffset = 0;
        _blacklist = blacklist;
        _connectionResolver = connectionResolver;
        _avStatisticsConsumer = avStatisticsConsumer;
    }
    return self;
}

- (void)requestPreloadMetadata:(BBCSMPItemProviderPreloadMetadataSuccess)success failure:(BBCSMPItemProviderFailure)failure
{
    BBCSMPItemPreloadMetadata* preloadMetadata = [BBCSMPItemPreloadMetadata new];
    [self configurePreloadMetadata:preloadMetadata];
    success(preloadMetadata);
}

- (void)requestPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure
{
    self.currentConnectionIndex = 0;
    [_blacklist removeAllMediaURLs];
    
    BBCMediaSelectorSecureConnectionPreference mediaSelectorPreference = [self convertSMPConnectionPreference: _preference];

    BBCMediaSelectorRequest* request = [[[[[[[BBCMediaSelectorRequest alloc] initWithVPID:_vpid] withMediaSet:_mediaSet] withTransferFormats:_transferFormats] withSAMLToken:_samlToken] withCeiling:_ceiling] withSecureConnectionPreference:mediaSelectorPreference];
    __weak typeof(self) weakSelf = self;
    [_mediaSelectorClient sendMediaSelectorRequest:request
        success:^(BBCMediaSelectorResponse* response) {
            weakSelf.mediaSelectorResponse = response;
            
            BBCSMPMediaSelectionLogMessage *message = [[BBCSMPMediaSelectionLogMessage alloc] initWithMediaItem:weakSelf.selectedItem];
            [[BBCSMPBackingOffMediaSelectorPlayerItemProvider logger] logMessage:message];
            
            BBCSMPMediaSelectorItem* playerItem = [weakSelf playerItemForCurrentConnection];
            
            if([playerItem isPlayable]) {
                [self logWeAreAttemptingToPlayPlayableItem:playerItem];
                 success(playerItem);
            } else {
                NSError* adapterError = [BBCSMPMediaSelectorErrorTransformer convertTypeToNSError: BBCSMPMediaSelectorErrorTypeGeneric];
                failure(adapterError);
            }
        }
        failure:^(NSError* error) {
        
        if (error.code == BBCMediaSelectorErrorGeoLocation) {
            NSError* adapterError = [BBCSMPMediaSelectorErrorTransformer convertTypeToNSError: BBCSMPMediaSelectorErrorTypeGeolocation];
            failure(adapterError);
        } else {
            NSError* adapterError = [BBCSMPMediaSelectorErrorTransformer convertTypeToNSError: BBCSMPMediaSelectorErrorTypeGeneric];
            failure(adapterError);
        }
            
        }];
}

- (void)logWeAreAttemptingToPlayPlayableItem:(BBCSMPMediaSelectorItem *)playerItem
{
    NSDictionary *attributes = @{ @"Href" : playerItem.mediaURL };
    
    NSMutableString *description = [NSMutableString string];
    [description appendString:@"About to attempt playback of:"];
    [description appendString:[attributes description]];
    
    BBCStringLogMessage *message = [BBCStringLogMessage messageWithMessage:description];
    [[BBCSMPBackingOffMediaSelectorPlayerItemProvider logger] logMessage:message];
}

- (BBCMediaSelectorSecureConnectionPreference) convertSMPConnectionPreference : (BBCSMPConnectionPreference) preference
{
    BBCMediaSelectorSecureConnectionPreference mediaSelectorPreference;
    
    switch (preference) {
        case BBCSMPConnectionPreferSecure:
        default:
            mediaSelectorPreference = BBCMediaSelectorSecureConnectionPreferSecure;
            break;
        case BBCSMPConnectionEnforceSecure:
            mediaSelectorPreference = BBCMediaSelectorSecureConnectionEnforceSecure;
            break;
        case BBCSMPConnectionEnforceNonSecure:
            mediaSelectorPreference = BBCMediaSelectorSecureConnectionEnforceNonSecure;
            break;
        case BBCSMPConnectionUseServerResponse:
            mediaSelectorPreference = BBCMediaSelectorSecureConnectionUseServerResponse;
            break;
    }

    return mediaSelectorPreference;
}

- (BOOL)failoverPlayerItemsAvailable
{
    return [self whitelistConnectionCount] > 0;
}

- (BBCMediaItem*)selectedItem
{
    return [_mediaSelectorResponse itemForHighestBitrate];
}

- (NSArray*)connections
{
    BBCMediaItem *selection = self.selectedItem;
    
    if(_suppliers)
    {
        NSMutableArray *requiredSuppliers = [[NSMutableArray alloc] init];
        for (NSString *supplier in _suppliers) {
            [requiredSuppliers addObjectsFromArray:[BBCSMPBackingOffMediaSelectorPlayerItemProvider supplierDictionary][supplier]];
        }
        [selection setConnectionFilter:[[BBCMediaConnectionFilter filter] withRequiredSuppliers:requiredSuppliers]];
    }

    return selection.connections;
}

- (NSUInteger)whitelistConnectionCount
{
    NSUInteger count = 0;
    NSMutableArray *connectionsExceptActiveConnection = [self.connections mutableCopy];
    [connectionsExceptActiveConnection removeObject:self.currentConnection];
    for (BBCMediaConnection *connection in connectionsExceptActiveConnection) {
        if (![_blacklist containsMediaURL:connection.href]) {
            count++;
        }
    }
    
    return count;
}

- (BBCMediaConnection*)currentConnection
{
    return _currentConnectionIndex < self.connections.count ? [self.connections objectAtIndex:_currentConnectionIndex] : nil;
}

- (BBCSMPMediaSelectorItem *)playerItemForCurrentConnection
{
    BBCSMPMediaSelectorItem* playerItem = [[BBCSMPMediaSelectorItem alloc] init];
    playerItem.mediaURL = [self.currentConnection href];
    playerItem.subtitleURL = [[[[_mediaSelectorResponse itemForCaptions] connections] firstObject] href];
    [self configurePreloadMetadata:playerItem.metadata.preloadMetadata];
    [self configureMetadata:playerItem.metadata];
    playerItem.metadata.avType = [self.selectedItem.kind isEqualToString:@"audio"] ? BBCSMPAVTypeAudio : BBCSMPAVTypeVideo;
    playerItem.metadata.supplier = [self.currentConnection supplier];
    playerItem.metadata.transferFormat = [self.currentConnection transferFormat];
    playerItem.actionOnBackground = _actionOnBackground;
    playerItem.playOffset = _playOffset;
    return playerItem;
}

- (void)updateCurrentConnectionIndex
{
    if (_currentConnectionIndex + 1 < self.connections.count) {
        _currentConnectionIndex++;
    }
    else {
        _currentConnectionIndex = 0;
    }
}

- (void)requestFailoverPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure
{
    BBCMediaConnection *connection = self.currentConnection;
    [_blacklist blacklistMediaURL:connection.href];
    
    if([self whitelistConnectionCount] > 0) {
        [self updateCurrentConnectionIndex];
        BBCSMPMediaSelectorItem *playerItem = [self playerItemForCurrentConnection];
        
        __weak typeof(self) weakSelf = self;
        [_connectionResolver resolvePlayerItem:playerItem usingPlayerItemCallback:^(id<BBCSMPItem> playerItem) {
            [weakSelf logWeAreAttemptingToPlayPlayableItem:playerItem];
            success(playerItem);
        }];
    }
    else {
        failure([NSError errorWithDomain:@"" code:0 userInfo:nil]);
    }
}

- (void)configureMetadata:(BBCSMPItemMetadata*)metadata
{
    metadata.avType = _avType;
    metadata.streamType = _streamType;
    switch (_streamType) {
    case BBCSMPStreamTypeVOD: {
        metadata.versionId = _vpid;
        break;
    }
    case BBCSMPStreamTypeSimulcast: {
        metadata.serviceId = _vpid;
        break;
    }
    default: {
        break;
    }
    }
    metadata.transferFormat = @"hls";
    metadata.contentId = _contentId;
}

- (void)configurePreloadMetadata:(BBCSMPItemPreloadMetadata*)preloadMetadata
{
    preloadMetadata.title = _title;
    preloadMetadata.subtitle = _subtitle;
    preloadMetadata.duration = _duration;
    if (_artworkURLProvider && !_artworkFetcher) {
        BBCSMPNetworkArtworkFetcher* bbcSMPNetworkArtworkFetcher = [[BBCSMPNetworkArtworkFetcher alloc] init];
        bbcSMPNetworkArtworkFetcher.artworkURLProvider = _artworkURLProvider;
        preloadMetadata.artworkFetcher = bbcSMPNetworkArtworkFetcher;
        _artworkFetcher = bbcSMPNetworkArtworkFetcher;
    }
    else {
        preloadMetadata.artworkFetcher = _artworkFetcher;
    }
    preloadMetadata.guidanceMessage = _guidanceMessage;
    [self configureMetadata:preloadMetadata.partialMetadata];
    preloadMetadata.customAvStatsLabels = self.customAVStatsLabels;
}

-(NSTimeInterval)initialPlayOffset{
    return self.playOffset;
}

@synthesize avStatisticsConsumer = _avStatisticsConsumer;

@end
