//
//  BBCSMPSettingsPersistenceFilesystem.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 23/06/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPSettingsPersistenceFilesystem.h"
#import "BBCSMPDefaultSettings.h"

static BBCSMPSettingsPersistenceFilesystem* __sharedDefaultSettingsPersistence;

@interface BBCSMPSettingsPersistenceFilesystem ()

@property (nonatomic, strong) NSOperationQueue* settingsWriteQueue;
@property (nonatomic, strong) NSMutableDictionary* settingsDictionary;
@property (nonatomic, strong) NSString* settingsFilePath;

@end

@implementation BBCSMPSettingsPersistenceFilesystem

static NSString* const BBCSMPDefaultSettingsStoreFilename = @"smp-ios.settings";

static NSString* const BBCSMPDefaultSettingsStoreMutedKey = @"muted";
static NSString* const BBCSMPDefaultSettingsStoreVolumeKey = @"volume";
static NSString* const BBCSMPDefaultSettingsStoreSubtitlesActiveKey = @"subtitlesActive";


+ (NSString*)defaultSettingsFilePath
{
    NSArray<NSString*>* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsFolder = [paths objectAtIndex:0];
    return [documentsFolder stringByAppendingPathComponent:BBCSMPDefaultSettingsStoreFilename];
}

- (instancetype)initWithSettingsWriteQueue:(NSOperationQueue*)settingsWriteQueue settingsFilePath:(NSString*)settingsFilePath defaultUnsetSubsValue:(BOOL)unsetDefaultValue
{
    if ((self = [super init])) {
        _settingsFilePath = settingsFilePath;
        _settingsWriteQueue = settingsWriteQueue;
        [self loadSettingsOrCreateDefaultsWith:unsetDefaultValue];
    }
    return self;
}

- (void)loadSettingsOrCreateDefaultsWith:(BOOL)unsetDefaultValue
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.settingsFilePath]) {
        self.settingsDictionary = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:_settingsFilePath]];
    } else {
        self.settingsDictionary = [NSMutableDictionary dictionaryWithDictionary:@{ BBCSMPDefaultSettingsStoreMutedKey : [NSNumber numberWithBool:[BBCSMPDefaultSettings BBCSMPDefaultSettingsMutedDefaultValue]],
            BBCSMPDefaultSettingsStoreSubtitlesActiveKey : [NSNumber numberWithBool:unsetDefaultValue] }];
    }
}

- (void)writeSettings
{
    NSDictionary* settingsDictionary = [NSDictionary dictionaryWithDictionary:self.settingsDictionary];
    __weak typeof(self) weakSelf = self;
    [_settingsWriteQueue addOperationWithBlock:^{
        [NSKeyedArchiver archiveRootObject:settingsDictionary toFile:weakSelf.settingsFilePath];
    }];
}

- (float)volume
{
    return [[_settingsDictionary valueForKey:BBCSMPDefaultSettingsStoreVolumeKey] floatValue];
}

- (void)setVolume:(float)volume
{
    @synchronized(self)
    {
        [_settingsDictionary setValue:[NSNumber numberWithFloat:volume] forKey:BBCSMPDefaultSettingsStoreVolumeKey];
    }
    [self writeSettings];
}

- (BOOL)muted
{
    return [[_settingsDictionary valueForKey:BBCSMPDefaultSettingsStoreMutedKey] boolValue];
}

- (void)setMuted:(BOOL)muted
{
    @synchronized(self)
    {
        [_settingsDictionary setValue:[NSNumber numberWithBool:muted] forKey:BBCSMPDefaultSettingsStoreMutedKey];
    }
    [self writeSettings];
}

- (BOOL)subtitlesActive
{
    return [[_settingsDictionary valueForKey:BBCSMPDefaultSettingsStoreSubtitlesActiveKey] boolValue];
}

- (void)setSubtitlesActive:(BOOL)subtitlesActive
{
    @synchronized(self)
    {
        [_settingsDictionary setValue:[NSNumber numberWithBool:subtitlesActive] forKey:BBCSMPDefaultSettingsStoreSubtitlesActiveKey];
    }
    [self writeSettings];
}

@end
