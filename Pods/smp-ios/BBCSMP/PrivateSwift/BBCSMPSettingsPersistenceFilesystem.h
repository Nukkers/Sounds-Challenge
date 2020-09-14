//
//  BBCSMPSettingsPersistenceFilesystem.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 23/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "BBCSMPSettingsPersistence.h"

@interface BBCSMPSettingsPersistenceFilesystem : NSObject <BBCSMPSettingsPersistence>

+ (NSString*)defaultSettingsFilePath;
- (instancetype)initWithSettingsWriteQueue:(NSOperationQueue*)settingsWriteQueue settingsFilePath:(NSString*)settingsFilePath defaultUnsetSubsValue:(BOOL)unsetDefaultValue;
@end
