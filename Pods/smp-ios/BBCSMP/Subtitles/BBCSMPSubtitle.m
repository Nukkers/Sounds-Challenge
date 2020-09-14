//
//  BBCSMPSubtitle.m
//  BBCMediaPlayer
//
//  Created by Douglas Dickinson on 29/10/2010.
//  Copyright 2010 BBC. All rights reserved.
//

#import "BBCSMPSubtitle.h"
#import "BBCSMPSubtitleChunk.h"
#import "BBCSMPSubtitleRegion.h"

@interface BBCSMPSubtitle ()

@property (nonatomic, assign) NSTimeInterval begin;
@property (nonatomic, assign) NSTimeInterval end;
@property (nonatomic, strong) NSDictionary* styleDictionary;
@property (nonatomic, strong) NSMutableArray<BBCSMPSubtitleChunk*>* mutableSubtitleChunks;

@end

@implementation BBCSMPSubtitle

- (instancetype)initWithBegin:(NSTimeInterval)begin end:(NSTimeInterval)end styleDictionary:(NSDictionary*)styleDictionary
{
    if ((self = [super init])) {
        _mutableSubtitleChunks = [[NSMutableArray alloc] init];
        _begin = begin;
        _end = end;
        _styleDictionary = styleDictionary;
    }
    return self;
}

- (NSArray<BBCSMPSubtitleChunk*>*)subtitleChunks
{
    return [NSArray arrayWithArray:_mutableSubtitleChunks];
}

- (void)addChunk:(BBCSMPSubtitleChunk*)chunk
{
    [_mutableSubtitleChunks addObject:chunk];
}

- (void)modifyLastChunkText:(NSString*)text
{
    [[_mutableSubtitleChunks lastObject] modifyText:text];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<%@:%p, begin = %f, end = %f, styleDictionary = %@, chunks = %@>", NSStringFromClass([self class]), self, self.begin, self.end, self.styleDictionary, self.subtitleChunks];
}

- (BOOL)hasPositionalSubtitles
{
    return _region != nil && [_region hasPositionalSubtitles];
}

- (BOOL)isActive:(NSTimeInterval)when
{
    return when >= _begin && when <= _end;
}

@end
