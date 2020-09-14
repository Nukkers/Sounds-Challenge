//
//  BBCSMPSubtitleManager.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 19/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPDefaultSettings.h"
#import "BBCSMPSubtitle.h"
#import "BBCSMPSubtitleFetcher.h"
#import "BBCSMPSubtitleFetcher.h"
#import "BBCSMPSubtitleFetcherFactory.h"
#import "BBCSMPSubtitleManager.h"
#import "BBCSMPSubtitleObserver.h"
#import "BBCSMPSubtitleParser.h"
#import "BBCSMPTime.h"
#import "BBCSMPObserverManager.h"
#import "BBCSMPSettingsPersistence.h"
#import "BBCSMPSubtitleParserResult.h"

static dispatch_queue_t subtitle_parsing_queue()
{
    static dispatch_queue_t subtitle_parsing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        subtitle_parsing_queue = dispatch_queue_create("uk.co.bbc.smp-ios.subtitle_parsing_queue", DISPATCH_QUEUE_SERIAL);
    });
    return subtitle_parsing_queue;
}

@interface BBCSMPSubtitleManager ()

@property (nonatomic, strong) NSArray* subtitlesArray;
@property (nonatomic, strong) NSDictionary* subtitleStyleDictionary;
@property (nonatomic, strong) NSString* subtitleBaseStyleKey;
@property (nonatomic, assign) BOOL subtitlesAvailable;
@property (nonatomic, assign) BOOL subtitlesActive;
@property (nonatomic, assign) NSTimeInterval currentOffset;
@property (nonatomic, strong) NSArray<BBCSMPSubtitle*>* currentSubtitles;
@property (nonatomic, strong) BBCSMPObserverManager* observerManager;
@property (nonatomic, assign) BOOL parseSubtitlesOnMainThread;
@property (nonatomic, assign) int mostRecentlyFoundSubtitleIndex;
@property (nonatomic, strong) id<BBCSMPSubtitleFetcher> subtitleFetcher;
@property (nonatomic, weak) id<BBCSMPSettingsPersistence> settings;

@end

@implementation BBCSMPSubtitleManager

#pragma mark Initialization

- (instancetype)initWithSettingsPersistence:(id<BBCSMPSettingsPersistence>)settingsPersistence
{
    self = [super init];
    if(self) {
        _observerManager = [[BBCSMPObserverManager alloc] init];
        _mostRecentlyFoundSubtitleIndex = 0;
        _settings = settingsPersistence;
        [self fetchPersistentValues];
    }
    
    return self;
}

- (void)fetchPersistentValues
{
    self.subtitlesActive = [_settings subtitlesActive];
}

- (void)activateSubtitles
{
    [self setSubtitlesActive:YES];
}

- (void)deactivateSubtitles
{
    [self setSubtitlesActive:NO];
}

#pragma mark - Player item observer

- (void)itemUpdated:(id<BBCSMPItem>)playerItem
{
    [self fetchSubtitlesForItem:playerItem];
}

#pragma mark - Player time observer

- (void)durationChanged:(BBCSMPDuration*)duration
{
}

- (void)timeChanged:(BBCSMPTime*)time
{
    switch (time.type) {
    case BBCSMPTimeRelative: {
        self.currentOffset = time.seconds;
        [self updateCurrentSubtitle];
        break;
    }
    case BBCSMPTimeAbsolute: {
        break;
    }
    default: {
        break;
    }
    }
}

- (void)seekableRangeChanged:(BBCSMPTimeRange*)range
{
}

- (void)scrubbedFromTime:(BBCSMPTime*)fromTime toTime:(BBCSMPTime*)toTime
{
    self.mostRecentlyFoundSubtitleIndex = 0;
}

- (void)playerRateChanged:(float)playerRate
{
}

#pragma mark - Subtitle fetching

- (void)fetchSubtitlesForItem:(id<BBCSMPItem>)item
{
    self.subtitlesAvailable = NO;
    self.subtitlesArray = nil;
    self.subtitleStyleDictionary = nil;
    self.subtitleBaseStyleKey = @"";
    self.mostRecentlyFoundSubtitleIndex = 0;
    id<BBCSMPSubtitleFetcher> subtitleFetcher = [BBCSMPSubtitleFetcherFactory subtitleFetcherForItem:item];
    _subtitleFetcher = subtitleFetcher;
    if (subtitleFetcher) {
        __weak __typeof(self) weakSelf = self;
        [subtitleFetcher fetchSubtitles:^(NSData* subtitleData) {
            if (weakSelf.parseSubtitlesOnMainThread) {
                [weakSelf parseSubtitles:subtitleData];
            }
            else {
                dispatch_async(subtitle_parsing_queue(), ^{
                    [weakSelf parseSubtitles:subtitleData];
                });
            }
        }
            failure:^(NSError* subtitleError) {
                [weakSelf setSubtitlesAvailable:NO];
            }];
    }
    else {
        [self setSubtitlesAvailable:NO];
    }
}

- (void)parseSubtitles:(NSData*)subtitleData
{
    BBCSMPSubtitleParser* parser = [[BBCSMPSubtitleParser alloc] init];
    BBCSMPSubtitleParserResult* subtitleParserResult = [parser parse:subtitleData];
    if (_parseSubtitlesOnMainThread) {
        [self updateSubtitlesFromParserResult:subtitleParserResult];
    }
    else {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateSubtitlesFromParserResult:subtitleParserResult];
        });
    }
}

- (void)updateSubtitlesFromParserResult:(BBCSMPSubtitleParserResult*)parserResult
{
    if (parserResult) {
        [self setSubtitlesAvailable:YES];
        self.subtitlesArray = parserResult.subtitles;
        [self updateSubtitleStyleDictionary:parserResult.styleDictionary subtitleBaseStyleKey:parserResult.baseStyleKey];
    }
    else {
        [self setSubtitlesAvailable:NO];
    }
}

- (void)setSubtitlesAvailable:(BOOL)subtitlesAvailable
{
    if (_subtitlesAvailable == subtitlesAvailable)
        return;

    _subtitlesAvailable = subtitlesAvailable;
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPSubtitleObserver)
                                       withBlock:^(id<BBCSMPSubtitleObserver> observer) {
                                           [observer subtitleAvailabilityChanged:[NSNumber numberWithBool:weakSelf.subtitlesAvailable]];
                                       }];
}

- (void)setSubtitlesActive:(BOOL)subtitlesActive
{
    if (_subtitlesActive == subtitlesActive)
        return;

    _subtitlesActive = subtitlesActive;
    __weak typeof(self) weakSelf = self;
    [_settings setSubtitlesActive:_subtitlesActive];
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPSubtitleObserver)
                                       withBlock:^(id<BBCSMPSubtitleObserver> observer) {
                                           [observer subtitleActivationChanged:[NSNumber numberWithBool:weakSelf.subtitlesActive]];
                                       }];
}

- (void)setCurrentSubtitles:(NSArray<BBCSMPSubtitle*>*)subtitles
{
    _currentSubtitles = subtitles;
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPSubtitleObserver)
                                       withBlock:^(id<BBCSMPSubtitleObserver> observer) {
                                           [observer subtitlesUpdated:weakSelf.currentSubtitles];
                                       }];
}

- (void)updateSubtitleStyleDictionary:(NSDictionary*)subtitleStyleDictionary subtitleBaseStyleKey:(NSString*)subtitleBaseStyleKey
{
    if (_subtitleStyleDictionary == subtitleStyleDictionary)
        return;

    _subtitleStyleDictionary = subtitleStyleDictionary;
    _subtitleBaseStyleKey = subtitleBaseStyleKey;
    __weak typeof(self) weakSelf = self;
    [_observerManager notifyObserversForProtocol:@protocol(BBCSMPSubtitleObserver)
                                       withBlock:^(id<BBCSMPSubtitleObserver> observer) {
                                           [observer styleDictionaryUpdated:weakSelf.subtitleStyleDictionary baseStyleKey:weakSelf.subtitleBaseStyleKey];
                                       }];
}

- (void)addObserver:(id<BBCSMPObserver>)observer
{
    [self.observerManager addObserver:observer];

    if ([observer conformsToProtocol:@protocol(BBCSMPSubtitleObserver)]) {
        [(id<BBCSMPSubtitleObserver>)observer subtitleAvailabilityChanged:@(_subtitlesAvailable)];
        [(id<BBCSMPSubtitleObserver>)observer subtitleActivationChanged:@(_subtitlesActive)];
        [(id<BBCSMPSubtitleObserver>)observer styleDictionaryUpdated:_subtitleStyleDictionary baseStyleKey:_subtitleBaseStyleKey];
        [(id<BBCSMPSubtitleObserver>)observer subtitlesUpdated:_currentSubtitles];
    }
}

- (void)removeObserver:(id<BBCSMPObserver>)observer
{
    [self.observerManager removeObserver:observer];
}

#pragma mark - Subtitle display updates

- (void)updateCurrentSubtitle
{
    if (_subtitlesActive) {
        [self calculateCurrentSubtitles];
    }
    else {
        [self setCurrentSubtitles:nil];
    }
}

- (void)calculateCurrentSubtitles
{
    __block NSMutableArray<BBCSMPSubtitle*>* currentSubtitles = [[NSMutableArray alloc] init];
    __block BOOL setThisPass = NO;
    NSUInteger subtitleCount = [_subtitlesArray count];

    for (int index = self.mostRecentlyFoundSubtitleIndex; index < subtitleCount; index++) {
        BBCSMPSubtitle* subtitle = [_subtitlesArray objectAtIndex:index];
        if ([subtitle isActive:_currentOffset]) {
            [currentSubtitles addObject:subtitle];

            if (!setThisPass) {
                self.mostRecentlyFoundSubtitleIndex = index;
                setThisPass = YES;
            }
        }

        if (subtitle.begin > _currentOffset) {
            break;
        }
    };
    [self setCurrentSubtitles:currentSubtitles];
}

@end
