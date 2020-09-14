//
//  BBCSMPItemProvider.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPItemPreloadMetadata;
@protocol BBCSMPItem;
@protocol BBCSMPAVStatisticsConsumer;

typedef void (^BBCSMPItemProviderSuccess)(id<BBCSMPItem> playerItem);
typedef void (^BBCSMPItemProviderFailure)(NSError* error);
typedef void (^BBCSMPItemProviderPreloadMetadataSuccess)(BBCSMPItemPreloadMetadata* preloadMetadata);

@protocol BBCSMPItemProvider <NSObject>

@property (strong, nonatomic, readonly) id<BBCSMPAVStatisticsConsumer> avStatisticsConsumer;

- (void)requestPreloadMetadata:(BBCSMPItemProviderPreloadMetadataSuccess)success failure:(BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestPreloadMetadata(success:failure:));

- (void)requestPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestPlayerItem(success:failure:));

/**
 Provide items for SMP to play when the initial item provided by requestPlayerItemProvider:failure: fails to
 play. Provide an error in the failure callback to signal there are no more available items to attempt
 playback with.
 */
- (void)requestFailoverPlayerItem:(BBCSMPItemProviderSuccess)success failure:(BBCSMPItemProviderFailure)failure NS_SWIFT_NAME(requestFailoverPlayerItem(success:failure:));


@optional
- (NSTimeInterval) initialPlayOffset;

@end
