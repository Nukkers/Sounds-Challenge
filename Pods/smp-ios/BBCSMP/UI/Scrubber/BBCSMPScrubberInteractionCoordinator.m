//
//  BBCSMPScrubberController.m
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/12/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPScrubberController.h"

@implementation BBCSMPScrubberController {
    NSMutableSet<id<BBCSMPScrubberInteractionObserver>> *_observers;
}

#pragma mark Initialization

- (instancetype)init
{
    self = [super init];
    if(self) {
        _observers = [NSMutableSet new];
    }
    
    return self;
}


#pragma mark Public

- (void)addObserver:(id<BBCSMPScrubberInteractionObserver>)observer
{
    [_observers addObject:observer];
}


#pragma mark BBCSMPScrubberSceneDelegate

- (void)scrubberSceneDidBeginScrubbing:(id<BBCSMPScrubberScene>)scrubberScene
{
    [_observers makeObjectsPerformSelector:@selector(scrubberDidBeginScrubbing)];
}

- (void)scrubberSceneDidFinishScrubbing:(id<BBCSMPScrubberScene>)scrubberScene
{
    [_observers makeObjectsPerformSelector:@selector(scrubberDidFinishScrubbing)];
}

- (void)scrubberScene:(id<BBCSMPScrubberScene>)scrubberScene didScrubToPosition:(NSNumber *)position
{
    for(id<BBCSMPScrubberInteractionObserver> observer in _observers) {
        [observer scrubberDidScrubToPosition:position];
    }
}

- (void)scrubberSceneDidReceiveAccessibilityIncrement:(id<BBCSMPScrubberScene>)scrubberScene
{
    [_observers makeObjectsPerformSelector:@selector(scrubberDidReceiveAccessibilityIncrement)];
}

- (void)scrubberSceneDidReceiveAccessibilityDecrement:(id<BBCSMPScrubberScene>)scrubberScene
{
    [_observers makeObjectsPerformSelector:@selector(scrubberDidReceiveAccessibilityDecrement)];
}

@end
