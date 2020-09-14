//
//  BBCSMPBackgroundTimeRequestController.m
//  httpclient-ios
//
//  Created by Ryan Johnstone on 30/10/2017.
//

#import "BBCSMPBackgroundResourceRequestController.h"
#import "BBCSMPBackgroundObserver.h"
#import "BBCSMPState.h"

@interface BBCSMPBackgroundResourceRequestController () <BBCSMPBackgroundObserver>
@property (nonatomic, strong) id<BBCSMPBackgroundTaskScheduler> backgroundTimeProvider;
@property (nonatomic, assign) BOOL isInBackground;
@property (nonatomic, assign) BBCSMPState *state;
@property (nonatomic, assign) BOOL taskRunning;
@property (nonatomic, assign) NSUInteger runningIdentifier;
@end

@implementation BBCSMPBackgroundResourceRequestController

- (instancetype)initWithBackgroundTimeProvider:(id<BBCSMPBackgroundTaskScheduler>)backgroundTimeProvider backgroundStateProvider:(id<BBCSMPBackgroundStateProvider>)backgroundStateProvider {
    self = [super init];
    if (self) {
        _backgroundTimeProvider = backgroundTimeProvider;
        [backgroundStateProvider addObserver:self];
    }
    
    return self;
}

- (void)playerEnteredBackgroundState {
    _isInBackground = YES;
}

- (void)playerEnteredForegroundState {
    _isInBackground = NO;
    [_backgroundTimeProvider endBackgroundTaskWithIdentifier:_runningIdentifier];
    _taskRunning = NO;
}

- (void)playerWillResignActive {
   
}

#pragma mark BBCSMPStateObserver

- (void)stateChanged:(BBCSMPState *)state {
    _state = state;

    if (state.state == BBCSMPStatePlaying) {
        [_backgroundTimeProvider endBackgroundTaskWithIdentifier:_runningIdentifier];
         _taskRunning = NO;
    } else if([self shouldRequestBackgroundResource]) {
        [self requestBackgroundResource];
    }
}

#pragma mark Private

- (BOOL)shouldRequestBackgroundResource {
    return (_isInBackground && (_state.state == BBCSMPStateBuffering || _state.state == BBCSMPStatePreparingToPlay || _state.state == BBCSMPStateLoadingItem) && !_taskRunning);
}

- (void)requestBackgroundResource {
    _taskRunning = YES;
    BBCSMPBackgroundResourceRequestController *controller = self;
    __weak typeof(self) weakSelf = self;
    _runningIdentifier = [_backgroundTimeProvider beginBackgroundTaskWithExpirationCallback:^ {
        [weakSelf.backgroundTimeProvider endBackgroundTaskWithIdentifier:controller.runningIdentifier];
        weakSelf.taskRunning = NO;
    }];
}

@end

