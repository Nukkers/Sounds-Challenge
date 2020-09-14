//
//  BBCSMPAVAudioSessionRouterAdapter.m
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 10/04/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import "BBCSMPAVAudioSessionRouterAdapter.h"
#import <AVFoundation/AVFoundation.h>

@implementation BBCSMPAVAudioSessionRouterAdapter {
    NSHashTable<id<BBCSMPAudioRouterObserver>> *_observers;
    AVAudioSession *_audioSession;
}

#pragma mark Initialization

- (instancetype)init
{
    return [self initWithNotificationCenter:[NSNotificationCenter defaultCenter]
                               audioSession:[AVAudioSession sharedInstance]];
}

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
                              audioSession:(AVAudioSession *)audioSession
{
    self = [super init];
    if (self) {
        _observers = [NSHashTable weakObjectsHashTable];
        _audioSession = audioSession;
        
        [notificationCenter addObserver:self
                               selector:@selector(audioRouteDidChange:)
                                   name:AVAudioSessionRouteChangeNotification
                                 object:audioSession];
    }
    
    return self;
}

#pragma mark BBCSMPAudioRouter

- (NSString *)currentPortName
{
    return [_audioSession.currentRoute.outputs.firstObject portType];
}

- (void)addAudioRouterObserver:(id<BBCSMPAudioRouterObserver>)observer
{
    [_observers addObject:observer];
    [self announceCurrentRouteToObserver:observer];
}

#pragma mark Private

- (void)announceCurrentRouteToObserver:(id<BBCSMPAudioRouterObserver>)observer
{
    [observer audioOutputDidChangeToRouteNamed:[self currentPortName]];
}

- (void)audioRouteDidChange:(NSNotification *)notification
{
    NSArray *observers = [_observers allObjects];
    dispatch_block_t notifyObservers = ^{
        for (id<BBCSMPAudioRouterObserver> observer in observers) {
            [self announceCurrentRouteToObserver:observer];
        }
    };
    
    if ([[NSThread currentThread] isMainThread]) {
        notifyObservers();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), notifyObservers);
    }
}

@end
