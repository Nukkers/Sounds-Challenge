//
//  BBCSMPUserInteractionStatisticsManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 26/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPUserInteractionStatisticsManager.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPUserInteractionObserver.h"
#import "BBCSMPUserInteractionStatisticsManagerEvent.h"
#import "BBCSMPUserInteractionStatisticsConsumer.h"

@interface BBCSMPUserInteractionStatisticsManager ()

@property (nonatomic, strong) BBCSMPObserverManager* observerManager;

@end

@implementation BBCSMPUserInteractionStatisticsManager

static NSString* const BBCSMPUserInteractionStatisticsManagerDefaultCounterName = @"smp-ios";
static NSString* const BBCSMPUserInteractionStatisticsManagerActionType = @"click";

- (instancetype)initWithCounterName:(NSString*)counterName
{
    if ((self = [super init])) {
        _counterName = counterName;
        _observerManager = [[BBCSMPObserverManager alloc] init];
        _observerManager.retainsObservers = YES;
    }
    return self;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _counterName = BBCSMPUserInteractionStatisticsManagerDefaultCounterName;
        _observerManager = [[BBCSMPObserverManager alloc] init];
        _observerManager.retainsObservers = YES;
    }
    return self;
}

- (void)addStatisticsConsumer:(id<BBCSMPUserInteractionStatisticsConsumer>)consumer
{
    NSAssert([consumer conformsToProtocol:@protocol(BBCSMPUserInteractionStatisticsConsumer)], @"Consumer does not conform to BBCSMPUserInteractionStatisticsConsumer protocol");
    [_observerManager addObserver:consumer];
}

- (void)removeStatisticsConsumer:(id<BBCSMPUserInteractionStatisticsConsumer>)consumer
{
    [_observerManager removeObserver:consumer];
}

- (void)trackUserInteractionWithActionName:(NSString*)actionName labels:(NSDictionary*)labels
{
    BBCSMPUserInteractionStatisticsManagerEvent* event = [[BBCSMPUserInteractionStatisticsManagerEvent alloc] init];
    event.counterName = _counterName;
    event.actionType = BBCSMPUserInteractionStatisticsManagerActionType;
    event.actionName = actionName;
    event.labels = labels;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPUserInteractionStatisticsConsumer)
                                       withBlock:^(id<BBCSMPUserInteractionStatisticsConsumer> consumer) {
                                           [consumer trackUserInteraction:event];
                                       }];
}

- (void)trackUserInteractionWithType:(NSString*)type andName:(NSString*)name
{
    BBCSMPUserInteractionStatisticsManagerEvent* event = [[BBCSMPUserInteractionStatisticsManagerEvent alloc] init];
    event.counterName = _counterName;
    event.actionType = type;
    event.actionName = name;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPUserInteractionStatisticsConsumer)
                                       withBlock:^(id<BBCSMPUserInteractionStatisticsConsumer> consumer) {
                                           [consumer trackUserInteraction:event];
                                       }];
}

- (void)trackUserInteractionWithActionName:(NSString*)actionName
{
    [self trackUserInteractionWithActionName:actionName labels:nil];
}

- (void)sendPageViewEvent
{
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPUserInteractionStatisticsConsumer)
                                       withBlock:^(id<BBCSMPUserInteractionStatisticsConsumer> consumer) {
                                           [consumer trackPageViewEvent:weakSelf.counterName];
                                       }];
}

#pragma mark - User interaction observer

- (void)playButtonTapped
{
    [self trackUserInteractionWithActionName:@"play"];
}

- (void)pauseButtonTapped
{
    [self trackUserInteractionWithActionName:@"pause"];
}

- (void)stopButtonTapped
{
    [self trackUserInteractionWithActionName:@"pause"];
}

- (void)scrubbedToPosition:(NSNumber*)position
{
    [self trackUserInteractionWithActionName:@"seek" labels:@{ @"seek_time" : position }];
}

- (void)activateSubtitlesButtonTapped
{
    [self trackUserInteractionWithActionName:@"subtitles_on"];
}

- (void)deactivateSubtitlesButtonTapped
{
    [self trackUserInteractionWithActionName:@"subtitles_off"];
}

- (void)muteButtonTapped
{
    [self trackUserInteractionWithActionName:@"mute"];
}

- (void)unmuteButtonTapped
{
    [self trackUserInteractionWithActionName:@"unmute"];
}

- (void)volumeSliderDisplayed
{
}

- (void)volumeSliderHidden
{
}

- (void)volumeChanged:(NSNumber*)volume
{
    [self trackUserInteractionWithActionName:@"volume_slider" labels:@{ @"volume" : [NSNumber numberWithUnsignedInteger:roundf([volume floatValue] * 11.0f)] }];
}

- (void)enterFullscreenButtonTapped
{
    [self trackUserInteractionWithActionName:@"enter_full_screen"];
}

- (void)leaveFullscreenButtonTapped
{
    [self trackUserInteractionWithActionName:@"exit_full_screen"];
}

- (void)startPictureInPictureTapped
{
}

- (void)stopPictureInPictureTapped
{
}

#pragma mark - BBCSMPPictureInPictureControllerObserver

- (void)didStopPictureInPicture
{
    [self trackUserInteractionWithType:@"picture-in-picture" andName:@"stop"];
}

- (void)didStartPictureInPicture
{
    [self trackUserInteractionWithType:@"picture-in-picture" andName:@"start"];
}
@end
