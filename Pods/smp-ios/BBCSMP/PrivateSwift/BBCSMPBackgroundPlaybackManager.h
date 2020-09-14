//
//  BBCSMPBackgroundPlaybackManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 20/08/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPPictureInPictureControllerObserver.h"

@class BBCSMPPictureInPictureController;
@protocol BBCSMP;
@protocol BBCSMPBackgroundStateProvider;
@protocol BBCSMPDisplayCoordinatorProtocol;

@interface BBCSMPBackgroundPlaybackManager : NSObject <BBCSMPPictureInPictureControllerObserver>
BBC_SMP_INIT_UNAVAILABLE
    
@property (nonatomic, assign, readonly) BOOL isAllowedToPlay;

- (instancetype)initWithPlayer:(id<BBCSMP>)player
       backgroundStateProvider:(id<BBCSMPBackgroundStateProvider>)backgroundStateProvider
            displayCoordinator:(id<BBCSMPDisplayCoordinatorProtocol>)displayCoordinator NS_DESIGNATED_INITIALIZER;

@end
