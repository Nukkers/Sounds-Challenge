#import "BBCSMPBackgroundManagerNotificationAdapter.h"
#import "BBCSMPBackgroundPlaybackManager.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPBackgroundObserver.h"
#import <UIKit/UIKit.h>

@implementation BBCSMPBackgroundManagerNotificationAdapter {
    __weak NSNotificationCenter *_notificationCenter;
    NSMutableSet<id<BBCSMPBackgroundObserver>> *_observers;
    BOOL _isActive;
}

#pragma mark Deallocation

- (void)dealloc
{
    [_notificationCenter removeObserver:self];
}

#pragma mark Initialization

- (instancetype)init
{
    return [self initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
}

- (instancetype)initWithNotificationCenter:(NSNotificationCenter*)notificationCenter
{
    self = [super init];
    if (self) {
        _notificationCenter = notificationCenter;
        _isActive = YES;
        _observers = [NSMutableSet set];
        
        [notificationCenter addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    
    return self;
}

#pragma mark Public

- (void)addObserver:(id<BBCSMPBackgroundObserver>)observer
{
    [_observers addObject:observer];
    [self provideCurrentBackgroundStateToObserver:observer];
}

- (void)removeObserver:(id<BBCSMPBackgroundObserver>)observer
{
    [_observers removeObject:observer];
}

#pragma mark Target-Action

- (void)appWillResignActive
{
    _isActive = NO;
    [_observers makeObjectsPerformSelector:@selector(playerWillResignActive)];
}

- (void)appDidEnterBackground
{
    _isActive = NO;
    [_observers makeObjectsPerformSelector:@selector(playerEnteredBackgroundState)];
}

#pragma mark Private

- (void)appDidBecomeActive
{
    _isActive = YES;
    [_observers makeObjectsPerformSelector:@selector(playerEnteredForegroundState)];
}

- (void)provideCurrentBackgroundStateToObserver:(id<BBCSMPBackgroundObserver>)observer
{
    if (_isActive) {
        [observer playerEnteredForegroundState];
    }
    else {
        [observer playerEnteredBackgroundState];
    }
}

@end
