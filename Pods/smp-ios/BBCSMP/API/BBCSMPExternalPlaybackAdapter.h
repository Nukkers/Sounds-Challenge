//
//  BBCSMPExternalPlaybackAdapter.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPExternalPlaybackAdapter;

@protocol BBCSMPExternalPlaybackAdapterDelegate <NSObject>
@required

- (void)externalPlaybackAdapterDidBeginAirplayPlayback:(id<BBCSMPExternalPlaybackAdapter>)externalPlaybackAdapter;
- (void)externalPlaybackAdapterDidEndAirplayPlayback:(id<BBCSMPExternalPlaybackAdapter>)externalPlaybackAdapter;

@end

@protocol BBCSMPExternalPlaybackAdapter <NSObject>
@required

@property (nonatomic, weak, nullable) id<BBCSMPExternalPlaybackAdapterDelegate> delegate;
@property (nonatomic, readonly, getter=isExternalPlaybackActive) BOOL externalPlaybackActive;

@end

NS_ASSUME_NONNULL_END
