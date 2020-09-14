//
//  BBCSMPSettingsPersistenceNone.m
//  BBCSMP
//
//  Created by Al Priest on 01/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPSettingsPersistenceNone.h"
#import "BBCSMPDefaultSettings.h"

@implementation BBCSMPSettingsPersistenceNone

- (BOOL)muted
{
    return [BBCSMPDefaultSettings BBCSMPDefaultSettingsMutedDefaultValue];
}

- (BOOL)subtitlesActive
{
    return [BBCSMPDefaultSettings BBCSMPDefaultSettingsSubtitlesActiveDefaultValue];
}

- (void)setMuted:(BOOL)muted {}
- (void)setSubtitlesActive:(BOOL)subtitlesActive {}

@end
