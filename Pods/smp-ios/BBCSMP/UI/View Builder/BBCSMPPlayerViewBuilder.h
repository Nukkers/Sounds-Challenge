//
//  BBCSMPPlayerViewBuilder.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 16/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPUIBuilder.h"
#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class BBCSMPAccessibilityIndex;
@protocol BBCSMP;
@protocol BBCSMPStateObservable;
@protocol BBCSMPVideoSurfaceManager;
@protocol BBCSMPPlayerViewFactory;
@protocol BBCSMPPlayerPresenterFactory;
@protocol BBCSMPAccessibilityAnnouncer;
@protocol BBCSMPTimeFormatterProtocol;
@protocol BBCSMPDeviceTraits;
@protocol BBCSMPAccessibilityStateProviding;
@protocol BBCSMPTimeIntervalFormatter;

@interface BBCSMPPlayerViewBuilder : NSObject <BBCSMPUIBuilder>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithPlayer:(id<BBCSMP, BBCSMPStateObservable>)player
           videoSurfaceManager:(id<BBCSMPVideoSurfaceManager>)videoSurfaceManager
              presenterFactory:(id<BBCSMPPlayerPresenterFactory>)presenterFactory NS_DESIGNATED_INITIALIZER;

- (instancetype)withViewFactory:(id<BBCSMPPlayerViewFactory>)viewFactory;
- (instancetype)withTimerFactory:(id<BBCSMPTimerFactoryProtocol>)timerFactory;
- (instancetype)withTimeFormatter:(id<BBCSMPTimeFormatterProtocol>)timeFormatter;
- (instancetype)withCallToActionTimeFormatter:(id<BBCSMPTimeFormatterProtocol>)callToActionTimeFormatter;
- (instancetype)withDeviceTraits:(id<BBCSMPDeviceTraits>)deviceTraits;
- (instancetype)withAccessibilityStateProviding:(id<BBCSMPAccessibilityStateProviding>)accessibilityStateProviding;
- (instancetype)withScrubberPositionFormatter:(id<BBCSMPTimeIntervalFormatter>)scrubberPositionFormatter;

@end

NS_ASSUME_NONNULL_END
