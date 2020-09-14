//
//  AVPlayerProtocol.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AVPlayerItem;

@protocol AVPlayerProtocol <NSObject>
@required

@property (nonatomic, readonly) AVPlayerStatus status;
@property (nonatomic) float rate;
@property (nonatomic, getter=isMuted) BOOL muted;
@property (nonatomic) float volume;
@property (nonatomic, readonly, nullable) NSError* error;
@property (nonatomic, readonly, getter=isExternalPlaybackActive) BOOL externalPlaybackActive;

- (void)play;
- (void)pause;

- (void)seekToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter;
- (void)seekToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter completionHandler:(void (^)(BOOL finished))completionHandler;

- (id)addPeriodicTimeObserverForInterval:(CMTime)interval queue:(nullable dispatch_queue_t)queue usingBlock:(void (^)(CMTime time))block;
- (void)removeTimeObserver:(id)observer;

- (void)addObserver:(NSObject*)observer forKeyPath:(NSString*)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void*)context;
- (void)removeObserver:(NSObject*)observer forKeyPath:(NSString*)keyPath context:(nullable void*)context;
- (void)removeObserver:(NSObject*)observer forKeyPath:(NSString*)keyPath;
- (void)prerollAtRate:(float)rate completionHandler:(nullable void (^)(BOOL finished))completionHandler;

- (void)replaceCurrentItemWithPlayerItem:(nullable AVPlayerItem *)item;

@end

NS_ASSUME_NONNULL_END
