//
//  BBCSMPPlayerInitialisationContext.h
//  BBCSMP
//
//  Created by Al Priest on 18/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPInterruptionEndedBehaviour.h"
#import "BBCSMPAVStatisticsHeartbeatGenerator.h"
#import "BBCSMPSystemSuspension.h"
#import <UIKit/UIKit.h>
#import <SMP/SMP-swift.h>

@class BBCSMPAudioManager;
@class BBCSMPUIScreenAdapterFactory;
@class BBCSMPSuspendRule;
@protocol BBCSMPItemProvider;
@protocol BBCSMPNetworkStatusProvider;
@protocol BBCSMPSettingsPersistence;
@protocol BBCSMPSettingsPersistenceFactory;
@protocol BBCSMPObserver;
@protocol BBCSMPPeriodicExecutorFactory;
@protocol BBCSMPVolumeProvider;
@protocol BBCSMPExternalDisplayProducer;
@protocol BBCSMPDecoderFactory;
@protocol BBCSMPTimerFactoryProtocol;
@protocol BBCSMPBackgroundStateProvider;
@protocol BBCSMPCommonAVReporting;
@protocol BBCSMPClock;
@protocol BBCSMPSessionIdentifierProvider;
@protocol BBCSMPRemoteCommandCenter;
@protocol MPNowPlayingInfoCenterProtocol;
@protocol BBCSMPAirplayAvailabilityProvider;
@protocol BBCSMPBackgroundTaskScheduler;
@protocol BBCSMPItemRetryRule;
@protocol BBCSMPAutorecoveryRule;
@protocol BBCSMPUIComposer;

@interface BBCSMPPlayerInitialisationContext : NSObject

@property (nonatomic, strong) id<BBCSMPNetworkStatusProvider> networkStatusProvider;
@property (nonatomic, strong) id<BBCSMPAirplayAvailabilityProvider> airplayAvailabilityProvider;
@property (nonatomic, strong) BBCSMPAudioManager* audioManager;
@property (nonatomic, strong) id<BBCSMPDecoderFactory> decoderFactory;
@property (nonatomic, strong) id<BBCSMPItemProvider> playerItemProvider;
@property (nonatomic, strong) id<BBCSMPSettingsPersistence> settingsPersistence;
@property (nonatomic, strong) id<BBCSMPSettingsPersistenceFactory> settingsPersistenceFactory;
@property (nonatomic, strong) id<BBCSMPPeriodicExecutorFactory> periodicExecutorFactory;
@property (nonatomic, strong) id<BBCSMPVolumeProvider> volumeProvider;
@property (nonatomic, strong) id<BBCSMPExternalDisplayProducer> externalDisplayProducer;
@property (nonatomic, strong) id<BBCSMPTimerFactoryProtocol> timerFactory;
@property (nonatomic, strong) BBCSMPSuspendRule* suspendRule;
@property (nonatomic, strong) id<BBCSMPBackgroundStateProvider> backgroundStateProvider;
@property (nonatomic, strong) id<BBCSMPCommonAVReporting> avMonitoringService;
@property (nonatomic, strong) id<BBCSMPClock> clock;
@property (nonatomic, strong) id<BBCSMPSessionIdentifierProvider> sessionIdentifierProvider;
@property (nonatomic, strong) id<BBCSMPRemoteCommandCenter> remoteCommandCenter;
@property (nonatomic, strong) id<MPNowPlayingInfoCenterProtocol> nowPlayingInfoCenter;
@property (nonatomic, strong) id<BBCSMPBackgroundTaskScheduler> backgroundTimeProvider;
@property (nonatomic, strong) id<BBCSMPItemRetryRule> itemRetryRule;
@property (nonatomic, strong) id<BBCSMPAutorecoveryRule> autorecoveryRule;
@property (nonatomic, assign) BBCSMPInterruptionEndedBehaviour interruptionEndedBehaviour;
@property (nonatomic, strong) id<BBCSMPUIComposer> uiComposer;
@property (nonatomic, strong) id<BBCSMPAVStatisticsHeartbeatGenerator> heartbeatGenerator;
@property (nonatomic, strong) id<BBCSMPSystemSuspension> systemSuspension;

- (NSArray<id<BBCSMPObserver> >*)playerObservers;
- (void)addObserver:(id<BBCSMPObserver>)observer;

@end
