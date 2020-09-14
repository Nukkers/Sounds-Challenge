//
//  BBCSMPNowPlayingInfoManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPPreloadMetadataObserver.h"
#import "BBCSMPTimeObserver.h"

@protocol BBCSMP;
@protocol MPNowPlayingInfoCenterProtocol;

@interface BBCSMPNowPlayingInfoManager : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) NSString* artistName;

- (instancetype)initWithPlayer:(id<BBCSMP>)player
          nowPlayingInfoCenter:(id<MPNowPlayingInfoCenterProtocol>)nowPlayingInfoCenter NS_DESIGNATED_INITIALIZER;

@end
