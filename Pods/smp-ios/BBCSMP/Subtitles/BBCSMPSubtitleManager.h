//
//  BBCSMPSubtitleManager.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPItemObserver.h"
#import "BBCSMPTimeObserver.h"

@protocol BBCSMPSettingsPersistence;

@interface BBCSMPSubtitleManager : NSObject <BBCSMPItemObserver, BBCSMPTimeObserver>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithSettingsPersistence:(id<BBCSMPSettingsPersistence>)settingsPersistence NS_DESIGNATED_INITIALIZER;

- (void)activateSubtitles;
- (void)deactivateSubtitles;
- (void)addObserver:(id<BBCSMPObserver>)observer;
- (void)removeObserver:(id<BBCSMPObserver>)observer;

@end
