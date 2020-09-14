//
//  BBCSMPAudioManager.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/04/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPAudioManager.h"
#import "BBCSMPAudioManagerObserver.h"
#import "BBCSMPAudioSession.h"
#import "BBCSMPObserverManager.h"

@interface BBCSMPAudioManager () <BBCSMPAudioSessionDelegate>

@property (nonatomic, strong) BBCSMPObserverManager* observerManager;
@property (nonatomic, strong) id<BBCSMPAudioSession> audioSession;

@end

@implementation BBCSMPAudioManager

- (instancetype)initWithAudioSession:(id<BBCSMPAudioSession>)audioSession
{
    if ((self = [super init])) {
        self.observerManager = [[BBCSMPObserverManager alloc] init];
        _audioSession = audioSession;
        _audioSession.delegate = self;
    }
    return self;
}

- (void)notifyObserversOfCurrentAudioRoute
{
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAudioManagerObserver)
                                       withBlock:^(id<BBCSMPAudioManagerObserver> observer) {
                                           if ([weakSelf isAudioRouteExternal]) {
                                               [observer audioTransitionedToExternalSession];
                                           }
                                           else {
                                               [observer audioTransitionedToInternalSession];
                                           }
                                       }];
}
- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [self.observerManager addObserver:observer];

    if ([observer conformsToProtocol:@protocol(BBCSMPAudioManagerObserver)]) {
        if ([self isAudioRouteExternal]) {
            [(id<BBCSMPAudioManagerObserver>)observer audioTransitionedToExternalSession];
        }
        else {
            [(id<BBCSMPAudioManagerObserver>)observer audioTransitionedToInternalSession];
        }
    }
}

- (void)removeObserver:(id<BBCSMPObserver>)observer
{
    [self.observerManager removeObserver:observer];
}

#pragma mark - BBCSMPAudioSessionDelegate

- (void)audioSessionRoutingDidChange:(id<BBCSMPAudioSession>)audioSession
{
    [self notifyObserversOfCurrentAudioRoute];
}

- (BOOL)isAudioRouteExternal
{
    return [_audioSession audioRoutedToExternalDevice];
}

@end
