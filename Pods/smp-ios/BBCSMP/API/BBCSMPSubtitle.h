//
//  BBCSMPSubtitle.h
//  BBCMediaPlayer
//
//  Created by Douglas Dickinson on 29/10/2010.
//  Copyright 2010 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@class BBCSMPSubtitleChunk;
@class BBCSMPSubtitleRegion;

@interface BBCSMPSubtitle : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, assign, readonly) NSTimeInterval begin;
@property (nonatomic, assign, readonly) NSTimeInterval end;
@property (nonatomic, strong, readonly) NSDictionary* styleDictionary;
@property (nonatomic, strong, readonly) NSArray<BBCSMPSubtitleChunk*>* subtitleChunks;
@property (nonatomic, strong) BBCSMPSubtitleRegion* region;

- (instancetype)initWithBegin:(NSTimeInterval)begin end:(NSTimeInterval)end styleDictionary:(NSDictionary*)styleDictionary NS_DESIGNATED_INITIALIZER;
- (void)addChunk:(BBCSMPSubtitleChunk*)chunk;
- (void)modifyLastChunkText:(NSString*)text;
- (BOOL)hasPositionalSubtitles;
- (BOOL)isActive:(NSTimeInterval)when NS_SWIFT_NAME(isActive(when:));

@end
