//
//  BBCSMPDisplayCoordinator.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 11/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPControllable.h"
#import "BBCSMPDisplayCoordinator.h"
#import "BBCSMPLayerProvider.h"
#import "BBCSMPObserver.h"
#import "BBCSMPPlayerObservable.h"
#import "BBCSMPRegisteredDisplay.h"
#import "BBCSMPVideoSurface.h"
#import "BBCSMPVideoSurfaceContext.h"
#import "BBCSMPVideoSurfaceAttachmentEvent.h"
#import <SMP/SMP-Swift.h>

@interface BBCSMPDisplayCoordinator () <BBCSMPPlaybackStateObserver>

@property (nonatomic, weak) id<BBCSMPPlayerObservable, BBCSMPControllable> player;
@property (nonatomic, strong) NSMutableArray<BBCSMPRegisteredDisplay*>* videoSurfaces;
@property (nonatomic, strong) BBCSMPEventBus* eventBus;

@end

@implementation BBCSMPDisplayCoordinator

#pragma mark Public

- (instancetype)initWithPlayer:(id<BBCSMPPlayerObservable, BBCSMPControllable>)player eventBus:(BBCSMPEventBus*)eventBus
{
    self = [super init];
    if (self) {
        _player = player;
        _videoSurfaces = [NSMutableArray new];
        [_player addStateObserver:self];
        _eventBus = eventBus;
    }

    return self;
}

- (void)setLayer:(CALayer<BBCSMPDecoderLayer>*)layer
{
    _layer = layer;

    [self detachTopmostScreen];
    BBCSMPVideoSurfaceContext* context = [[BBCSMPVideoSurfaceContext alloc] initWithPlayerLayer:layer observable:_player];
    [self.topmostScreen attachWithContext:context];
}

#pragma mark BBCSMPDisplayCoordinatorProtocol

- (BOOL)playbackShouldContinueWhenBackgrounding
{
    return self.topmostScreen.shouldPlayInBackground;
}

- (void)attachVideoSurface:(id<BBCSMPVideoSurface>)videoSurface
{
    if (![self containsScreen:videoSurface]) {
        [self addScreen:videoSurface];
        BBCSMPVideoSurfaceAttachmentEvent *event = [[BBCSMPVideoSurfaceAttachmentEvent alloc] init];
        event.videoSurfaces = @([_videoSurfaces count]);
        [_eventBus sendEvent:event];

        if (_videoSurfaces.count == 1) {
            [self provideLayerToScreen:videoSurface];
        }
        else if ([[_videoSurfaces lastObject].videoSurface isEqual:videoSurface]) {
            id<BBCSMPVideoSurface> previousScreen = _videoSurfaces[_videoSurfaces.count - 2].videoSurface;
            [previousScreen detach];
            [self provideLayerToScreen:videoSurface];
        }
    }
    
}

- (void)detachVideoSurface:(id<BBCSMPVideoSurface>)videoSurface
{
    NSUInteger index = [self indexOfScreen:videoSurface];
    if (index != NSNotFound) {
        [videoSurface detach];
       
        [self reattatchScreenBeforeScreenAtIndex:index];
        [_videoSurfaces removeObjectAtIndex:index];
        
        BBCSMPVideoSurfaceAttachmentEvent *event = [[BBCSMPVideoSurfaceAttachmentEvent alloc] init];
        event.videoSurfaces = @([_videoSurfaces count]);
        [_eventBus sendEvent:event];
        
        if ([videoSurface shouldPauseWhenDetached]) {
            [_player pause];
        }
    }

}

#pragma mark PlaybackStateObserver

- (void)state:(id<SMPPlaybackState>)state
{
    id playbackState = state;
    if ([playbackState isKindOfClass:[SMPPlaybackStateEnded class]]) {
        [self detachTopmostScreen];
    }
}

#pragma mark Private

- (void)addScreen:(id<BBCSMPVideoSurface>)screenToAdd
{
    BBCSMPRegisteredDisplay* display = [[BBCSMPRegisteredDisplay alloc] initWithVideoSurface:screenToAdd];
    [_videoSurfaces addObject:display];

    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"videoSurface.priority" ascending:YES];
    [_videoSurfaces sortUsingDescriptors:@[ descriptor ]];
}

- (id<BBCSMPVideoSurface>)topmostScreen
{
    return [_videoSurfaces lastObject].videoSurface;
}

- (void)detachTopmostScreen
{
    [self.topmostScreen detach];
}

- (void)reattatchScreenBeforeScreenAtIndex:(NSUInteger)index
{
    if (index == (_videoSurfaces.count - 1) && _videoSurfaces.count > 1) {
        id<BBCSMPVideoSurface> previousScreen = _videoSurfaces[index - 1].videoSurface;
        [self provideLayerToScreen:previousScreen];
    }
}

- (void)provideLayerToScreen:(id<BBCSMPVideoSurface>)screen
{
    BBCSMPVideoSurfaceContext* context = [[BBCSMPVideoSurfaceContext alloc] initWithPlayerLayer:_layer observable:_player];
    [screen attachWithContext:context];
}

- (BOOL)containsScreen:(id<BBCSMPVideoSurface>)screen
{
    return [self indexOfScreen:screen] != NSNotFound;
}

- (NSUInteger)indexOfScreen:(id<BBCSMPVideoSurface>)screen
{
    for (NSUInteger index = 0; index < _videoSurfaces.count; index++) {
        if ([_videoSurfaces[index].videoSurface isEqual:screen]) {
            return index;
        }
    }

    return NSNotFound;
}

@end
