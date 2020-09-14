//
//  BBCSMPSettingsPersistence.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 23/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBCSMPSettingsPersistence <NSObject>

- (BOOL)muted;
- (void)setMuted:(BOOL)muted;
- (BOOL)subtitlesActive;
- (void)setSubtitlesActive:(BOOL)subtitlesActive;

@end
