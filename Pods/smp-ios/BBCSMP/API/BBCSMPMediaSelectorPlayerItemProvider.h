//
//  BBCSMPMediaSelectorPlayerItemProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPConnectionPreference.h"
#import <SMP/SMP.h>
#import <MediaSelector/BBCMediaSelectorClient.h>

@class BBCSMPDuration;
@protocol BBCSMPArtworkURLProvider;
@protocol BBCSMPMediaURLBlacklist;

BBC_SMP_DEPRECATED("Please use the swift class MediaSelectorItemProviderBuilder to create Media Selector Item Providers")
@interface BBCSMPMediaSelectorPlayerItemProvider : NSObject <BBCSMPItemProvider>
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSString* contentId;
@property (nonatomic, strong) NSString* samlToken;
@property (nonatomic, strong) NSString* ceiling;
@property (nonatomic, assign) BBCSMPStreamType streamType;
@property (nonatomic, assign) BBCSMPBackgroundAction actionOnBackground;
@property (nonatomic, strong) id<BBCSMPArtworkURLProvider> artworkURLProvider;
@property (nonatomic, strong) BBCSMPDuration* duration;
@property (nonatomic, strong) NSString* guidanceMessage;
@property (nonatomic, assign) BBCSMPAVType avType;
@property (nonatomic, assign) NSTimeInterval playOffset;
@property (nonatomic, assign) BBCSMPConnectionPreference preference;
@property (nonatomic, strong) NSArray* suppliers;
@property (nonatomic, strong) NSDictionary<NSString*, NSString*>* customAVStatsLabels;

- (instancetype)initWithMediaSet:(NSString*)mediaSet vpid:(NSString*)vpid BBC_SMP_DEPRECATED("Please use the swift class MediaSelectorItemProviderBuilder to create Media Selector Item Providers");
- (instancetype)initWithMediaSelectorClient:(BBCMediaSelectorClient*)mediaSelectorClient mediaSet:(NSString*)mediaSet vpid:(NSString*)vpid BBC_SMP_DEPRECATED("Please use the swift class MediaSelectorItemProviderBuilder to create Media Selector Item Providers");
- (instancetype)initWithMediaSelectorClient:(BBCMediaSelectorClient*)mediaSelectorClient
                                   mediaSet:(NSString*)mediaSet
                                       vpid:(NSString*)vpid
                             artworkFetcher:(id<BBCSMPArtworkFetcher>)artworkFetcher BBC_SMP_DEPRECATED("Please use the swift class MediaSelectorItemProviderBuilder to create Media Selector Item Providers");
- (instancetype)initWithMediaSelectorClient:(BBCMediaSelectorClient*)mediaSelectorClient
                                   mediaSet:(NSString*)mediaSet
                                       vpid:(NSString*)vpid
                             artworkFetcher:(id<BBCSMPArtworkFetcher>)artworkFetcher
                                  blacklist:(id<BBCSMPMediaURLBlacklist>)blacklist NS_DESIGNATED_INITIALIZER BBC_SMP_DEPRECATED("Please use the swift class MediaSelectorItemProviderBuilder to create Media Selector Item Providers");


+ (NSDictionary*) supplierDictionary;

@end
