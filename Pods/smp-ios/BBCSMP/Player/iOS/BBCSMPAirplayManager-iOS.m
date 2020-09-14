//
//  BBCSMPAirplayManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 15/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPAirplayManager.h"
#import "BBCSMPExternalPlaybackAdapter.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPAirplayAvailabilityProvider.h"
#import "BBCSMPAirplayObserver.h"

@interface BBCSMPAirplayManager () <BBCSMPAirplayAvailabilityProviderDelegate,
                                    BBCSMPExternalPlaybackAdapterDelegate>

@property (nonatomic, strong) id<BBCSMPAirplayAvailabilityProvider> airplayAvailabilityProvider;
@property (nonatomic, strong) BBCSMPObserverManager* observerManager;
@property (nonatomic, assign, readwrite) BOOL airplayAvailable;
@property (nonatomic, assign, readwrite) BOOL airplayActive;

@end

#pragma mark -

@implementation BBCSMPAirplayManager

#pragma mark Initialization

- (instancetype)initWithAirplayAvailabilityProvider:(id<BBCSMPAirplayAvailabilityProvider>)airplayAvailabilityProvider;
{
    self = [super init];
    if(self) {
        _observerManager = [[BBCSMPObserverManager alloc] init];
        _airplayActive = NO;
        _airplayAvailabilityProvider = airplayAvailabilityProvider;
        _airplayAvailabilityProvider.delegate = self;
    }
    
    return self;
}

#pragma mark Public

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [self.observerManager addObserver:observer];

    if ([observer conformsToProtocol:@protocol(BBCSMPAirplayObserver)]) {
        [(id<BBCSMPAirplayObserver>)observer airplayAvailabilityChanged:@(_airplayAvailable)];
        [(id<BBCSMPAirplayObserver>)observer airplayActivationChanged:@(_airplayActive)];
    }
}

- (void)removeObserver:(id<BBCSMPObserver>)observer
{
    [self.observerManager removeObserver:observer];
}

#pragma mark - State updates

- (void)setAirplayAvailable:(BOOL)available
{
    if (_airplayAvailable == available)
        return;

    _airplayAvailable = available;

    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAirplayObserver)
                                       withBlock:^(id<BBCSMPAirplayObserver> observer) {
                                           [observer airplayAvailabilityChanged:@(available)];
                                       }];
}

- (void)setAirplayActive:(BOOL)active
{
    if (_airplayActive == active)
        return;

    _airplayActive = active;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPAirplayObserver)
                                       withBlock:^(id<BBCSMPAirplayObserver> observer) {
                                           [observer airplayActivationChanged:@(active)];
                                       }];
}

- (void)setExternalPlaybackAdapter:(id<BBCSMPExternalPlaybackAdapter>)externalPlaybackAdapter
{
    _externalPlaybackAdapter = externalPlaybackAdapter;
    [externalPlaybackAdapter setDelegate:self];
    self.airplayActive = [externalPlaybackAdapter isExternalPlaybackActive];
}

- (void)externalPlaybackAdapterDidBeginAirplayPlayback:(id<BBCSMPExternalPlaybackAdapter>)externalPlaybackAdapter
{
    self.airplayActive = YES;
}

- (void)externalPlaybackAdapterDidEndAirplayPlayback:(id<BBCSMPExternalPlaybackAdapter>)externalPlaybackAdapter
{
    self.airplayActive = NO;
}

#pragma mark BBCSMPAirplayAvailabilityProviderDelegate

- (void)airplayProviderDidResolveAirplayAvailable:(id<BBCSMPAirplayAvailabilityProvider>)airplayProvider
{
    self.airplayAvailable = YES;
}

- (void)airplayProviderDidResolveAirplayUnavailable:(id<BBCSMPAirplayAvailabilityProvider>)airplayProvider
{
    self.airplayAvailable = NO;
}

@end
