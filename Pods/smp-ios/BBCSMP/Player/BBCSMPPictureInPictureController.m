//
//  BBCSMPPictureInPictureAdapter.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 24/03/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAVPictureInPictureAdapter.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPPictureInPictureController.h"
#import "BBCSMPPictureInPictureControllerObserver.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPPictureInPictureController () <BBCSMPPlaybackStateObserver>

@property (nonatomic, strong) BBCSMPObserverManager* observerManager;
@property (nonatomic, copy) void (^stopPictureInPictureCompletionHandler)(void);
@property (nonatomic, assign, getter=isPictureInPictureActive) BOOL pictureInPictureActive;

@end

@implementation BBCSMPPictureInPictureController

- (instancetype)init
{
    if (self = [super init]) {
        _observerManager = [BBCSMPObserverManager new];
    }

    return self;
}

- (void)setAdapter:(id<BBCSMPPictureInPictureAdapter>)adapter
{
    if (_adapter && _pictureInPictureActive) {
        _pictureInPictureActive = NO;
        [self.adapter stopPictureInPicture];
        [self notifyDidStopPictureInPicture];
    }

    _adapter = adapter;
    _pictureInPictureActive = _adapter.isPictureInPictureActive;
    [_adapter setDelegate:self];
}

- (void)addObserver:(id<BBCSMPPictureInPictureControllerObserver>)observer
{
    [self.observerManager addObserver:observer];

    if (_pictureInPictureActive) {
        [observer didStartPictureInPicture];
    }
    else {
        [observer didStopPictureInPicture];
    }
}

- (void)removeObserver:(id<BBCSMPPictureInPictureControllerObserver>)observer
{
    [self.observerManager removeObserver:observer];
}

- (BOOL)supportsPictureInPicture
{
    return [self.adapter supportsPictureInPicture];
}

- (void)stopPictureInPictureWithCompletionHandler:(void (^)(void))completionHandler
{
    self.stopPictureInPictureCompletionHandler = completionHandler;

    if (self.isPictureInPictureActive) {
        [self.adapter stopPictureInPicture];
    }
    else {
        [self invokeCompletionHandler];
    }
}

- (void)startPictureInPicture
{
    [self.adapter startPictureInPicture];
}

- (void)pictureInPictureAdapterDidStopPictureInPicture
{
    _pictureInPictureActive = NO;
    [self invokeCompletionHandler];

    [self notifyDidStopPictureInPicture];
}

- (void)notifyDidStopPictureInPicture
{
    [self.observerManager notifyObserversForProtocol:@protocol(BBCSMPPictureInPictureControllerObserver)
                                           withBlock:^(id observer) {
                                               [observer didStopPictureInPicture];
                                           }];
}

- (void)pictureInPictureAdapterWillStartPictureInPicture
{
    _pictureInPictureActive = YES;
    [self.observerManager notifyObserversForProtocol:@protocol(BBCSMPPictureInPictureControllerObserver)
                                           withBlock:^(id observer) {
                                               [observer didStartPictureInPicture];
                                           }];
}

- (void)invokeCompletionHandler
{
    if (self.stopPictureInPictureCompletionHandler) {
        self.stopPictureInPictureCompletionHandler();
        self.stopPictureInPictureCompletionHandler = nil;
    }
}

- (void)state:(id<SMPPlaybackState>)state
{
    id playbackState = state;
    if ([playbackState isKindOfClass:[SMPPlaybackStateFailed class]]) {
        [self stopPictureInPictureWithCompletionHandler:nil];
    }
}

@end
