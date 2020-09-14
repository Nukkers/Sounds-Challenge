//
//  BBCSMPState.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPState.h"

NSString* NSStringFromBBCSMPStateEnumeration(BBCSMPStateEnumeration state)
{
    NSArray<NSString*>* stateDescriptions = @[ @"BBCSMPStateIdle", @"BBCSMPStateLoadingItem", @"BBCSMPStateItemLoaded", @"BBCSMPStatePreparingToPlay", @"BBCSMPStatePlayerReady", @"BBCSMPStatePlaying", @"BBCSMPStateBuffering", @"BBCSMPStatePaused", @"BBCSMPStateEnded", @"BBCSMPStateError", @"BBCSMPStateStopping", @"BBCSMPStateInterrupted" ];
    return stateDescriptions[state];
}

#pragma mark -

@interface BBCSMPState ()

@property (nonatomic, assign) BBCSMPStateEnumeration state;

@end

#pragma mark -

@implementation BBCSMPState

+ (instancetype)idleState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateIdle];
}

+ (instancetype)loadingItemState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateLoadingItem];
}

+ (instancetype)itemLoadedState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateItemLoaded];
}

+ (instancetype)preparingToPlayState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStatePreparingToPlay];
}

+ (instancetype)playerReadyState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStatePlayerReady];
}

+ (instancetype)playingState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStatePlaying];
}

+ (instancetype)bufferingState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateBuffering];
}

+ (instancetype)pausedState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStatePaused];
}

+ (instancetype)endedState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateEnded];
}

+ (instancetype)errorState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateError];
}

+ (instancetype)stoppingState
{
    return [[BBCSMPState alloc] initWithEnumeration:BBCSMPStateStopping];
}

- (instancetype)initWithEnumeration:(BBCSMPStateEnumeration)stateEnumeration
{
    if ((self = [super init])) {
        _state = stateEnumeration;
    }
    
    return self;
}

- (NSString*)description
{
    return NSStringFromBBCSMPStateEnumeration(_state);
}

- (NSString*)debugDescription
{
    return [self description];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]])
        return NO;

    return ([(BBCSMPState*)object state] == _state);
}

@end
