//
//  BBCSMPPlayer.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 13/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPClock.h"
#import "BBCSMPProtocol.h"
#import "BBCSMPStateObservable.h"
#import "BBCSMPVideoSurfaceManager.h"

@class BBCSMPPlayerInitialisationContext;
@protocol BBCSMPItem;

@interface BBCSMPPlayer : NSObject <BBCSMP, BBCSMPStateObservable, BBCSMPVideoSurfaceManager, BBCSMPClockDelegate>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithContext:(BBCSMPPlayerInitialisationContext*)context NS_DESIGNATED_INITIALIZER;

@end
