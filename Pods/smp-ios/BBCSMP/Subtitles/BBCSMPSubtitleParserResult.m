//
//  BBCSMPSubtitleParserResult.m
//  BBCSMP
//
//  Created by Michael Emmens on 09/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleParserResult.h"

@interface BBCSMPSubtitleParserResult ()

@property (nonatomic, strong) NSDictionary* styleDictionary;
@property (nonatomic, strong) NSArray<BBCSMPSubtitle*>* subtitles;
@property (nonatomic, strong) NSString* baseStyleKey;

@end

@implementation BBCSMPSubtitleParserResult

- (instancetype)initWithStyleDictionary:(NSDictionary*)styleDictionary
                              subtitles:(NSArray<BBCSMPSubtitle*>*)subtitles
                           baseStyleKey:(NSString *)baseStyleKey
{
    if ((self = [super init])) {
        _styleDictionary = styleDictionary;
        _subtitles = subtitles;
        _baseStyleKey = baseStyleKey;
    }
    return self;
}

@end
