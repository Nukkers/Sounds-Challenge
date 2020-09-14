//
//  BBCSMPSubtitleParser.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 03/06/2015.
//  Copyright 2015 BBC. All rights reserved.
//

#import "BBCSMPSubtitleParser.h"
#import "BBCSMPSubtitle.h"
#import "BBCSMPSubtitleRegion.h"
#import "BBCSMPSubtitleChunk.h"
#import "BBCSMPSubtitleParserResult.h"

@interface BBCSMPSubtitleParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableDictionary* styleDictionary;
@property (nonatomic, strong) NSMutableArray* subtitles;
@property (nonatomic, strong) NSString* baseStyleKey;

@property (nonatomic, strong) NSXMLParser* parser;
@property (nonatomic, strong, readonly) BBCSMPSubtitle* currentSubtitle;
@property (nonatomic, strong) NSMutableString* value;
@property (nonatomic, strong) NSMutableDictionary* regions;
@property (nonatomic, assign) BOOL inSpan;
@property (nonatomic, strong) NSString* positionalSubtitleCellResolution;

@end

@implementation BBCSMPSubtitleParser

static NSString* const NEWLINE = @"\n";

- (BBCSMPSubtitleParserResult*)parse:(NSData*)utf8EncodedXMLData
{
    self.styleDictionary = [NSMutableDictionary dictionary];
    self.subtitles = [NSMutableArray array];
    self.regions = [NSMutableDictionary dictionary];

    self.parser = [[NSXMLParser alloc] initWithData:utf8EncodedXMLData];
    _parser.delegate = self;
    [_parser parse];

    NSSortDescriptor* startTime = [NSSortDescriptor sortDescriptorWithKey:@"begin" ascending:YES];
    [_subtitles sortUsingDescriptors:@[ startTime ]];

    return [[BBCSMPSubtitleParserResult alloc] initWithStyleDictionary:[NSDictionary dictionaryWithDictionary:_styleDictionary]
                                                             subtitles:[NSArray arrayWithArray:_subtitles]
                                                          baseStyleKey:_baseStyleKey];
}

- (NSDictionary*)styleDictionaryFromDictionary:(NSDictionary*)dictionary
{
    NSMutableDictionary* styleDictionary = [NSMutableDictionary dictionaryWithCapacity:2];
    [styleDictionary setValue:dictionary[@"style"] forKey:@"style"];
    if ([dictionary objectForKey:@"color"]) {
        [styleDictionary setValue:dictionary[@"color"] forKey:@"color"];
    }
    if ([dictionary objectForKey:@"fontStyle"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"fontStyle"] forKey:@"fontStyle"];
    }
    if ([dictionary objectForKey:@"textAlign"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"textAlign"] forKey:@"textAlign"];
    }
    if ([dictionary objectForKey:@"fontSize"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"fontSize"] forKey:@"fontSize"];
        [styleDictionary setValue:self.positionalSubtitleCellResolution forKey:@"cellResolution"];
    }
    if ([dictionary objectForKey:@"backgroundColor"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"backgroundColor"] forKey:@"backgroundColor"];
    }
    if ([dictionary objectForKey:@"lineHeight"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"lineHeight"] forKey:@"lineHeight"];
    }
    if ([dictionary objectForKey:@"fillLineGap"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"fillLineGap"] forKey:@"fillLineGap"];
    }
    if ([dictionary objectForKey:@"linePadding"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"linePadding"] forKey:@"linePadding"];
    }
    if ([dictionary objectForKey:@"fontFamily"]) {
        [styleDictionary setValue:[dictionary objectForKey:@"fontFamily"] forKey:@"fontFamily"];
    }

    return [NSDictionary dictionaryWithDictionary:styleDictionary];
    
}

- (BBCSMPSubtitle*)currentSubtitle
{
    return [_subtitles lastObject];
}

- (void)addSubtitleWithAttributes:(NSDictionary*)attributes
{
    BBCSMPSubtitle* subtitle = [[BBCSMPSubtitle alloc] initWithBegin:[[self class] timeIntervalFromHms:attributes[@"begin"]]
                                                                 end:[[self class] timeIntervalFromHms:attributes[@"end"]]
                                                     styleDictionary:attributes[@"style"] ? @{ @"style" : attributes[@"style"] } : nil];
    NSString* regionId = attributes[@"region"];
    [subtitle setRegion:[self.regions valueForKey:regionId]];

    [_subtitles addObject:subtitle];
}

- (void)addSubtitleChunkWithAttributes:(NSDictionary*)attributes text:(NSString*)text
{
    NSMutableDictionary* chunkAttributes = [[NSMutableDictionary alloc] init];
    if (attributes[@"color"]) {
        [chunkAttributes setValue:attributes[@"color"] forKey:@"color"];
    }
    if (attributes[@"style"]) {
        [chunkAttributes setValue:attributes[@"style"] forKey:@"style"];
    }
    if ([chunkAttributes count] == 0) {
        chunkAttributes = nil;
    }

    BBCSMPSubtitleChunk* chunk = [[BBCSMPSubtitleChunk alloc] initWithText:text styleDictionary:chunkAttributes];
    [self.currentSubtitle addChunk:chunk];
}

+ (NSTimeInterval)timeIntervalFromHms:(NSString*)hmsString
{
    static double m[] = {
        60.0 * 60.0, // seconds per hour
        60.0, // seconds per minute
        1.0, // seconds per second
    };

    NSTimeInterval result = 0.0;
    NSArray<NSString*>* parts = [hmsString componentsSeparatedByString:@":"];
    // start at the seconds end to handle ss.s, mm:ss.s and hh:mm:ss.s
    for (NSInteger i = [parts count] - 1; i >= 0; i--) {
        result += [[parts objectAtIndex:i] doubleValue] * m[i];
    }

    return result;
}

#pragma mark - NSXMLParserDelegate methods

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary*)attributes
{
    elementName = [self stripXMLPrefixesFromString:elementName];
    attributes = [self stripXMLPrefixesFromStringsInDictionary:attributes];

    if ([elementName isEqualToString:@"tt"]) {
        self.positionalSubtitleCellResolution = [attributes objectForKey:@"cellResolution"];
    } else if ([elementName isEqualToString:@"style"]) {
        [self addStyleDictionaryIfId:@"id" isPresentInAttributes:attributes];
    } else if ([elementName isEqualToString:@"p"]) {
        [self addSubtitleWithAttributes:attributes];
        _value = nil;
    } else if ([elementName isEqualToString:@"span"]) {
        _inSpan = YES;
        [self addChunkIfValidCharactersPending];
        [self addSubtitleChunkWithAttributes:attributes text:nil];
    } else if ([elementName isEqualToString:@"br"]) {
        return;
    } else if ([elementName isEqualToString:@"region"]) {
        BBCSMPSubtitleRegion* region = [[BBCSMPSubtitleRegion alloc] initWithAttributes:attributes];
        if (region != nil) {
            [_regions setObject:region forKey:[region regionId]];
        }
    } else if ([elementName isEqualToString:@"div"] || [elementName isEqualToString:@"body"]) {
        [self assignBaseStyleKeyFromAttributes:attributes];
    }
}

- (void)parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName
{
    elementName = [self stripXMLPrefixesFromString:elementName];

    if ([elementName isEqualToString:@"p"]) {
        [self addChunkIfValidCharactersPending];
    } else if ([elementName isEqualToString:@"span"]) {
        _inSpan = NO;
        if (_value.length > 0) {
            if ([self isNotJustWhitespace:_value]) {
                [self.currentSubtitle modifyLastChunkText:_value];
            }
            _value = nil;
        }
    } else if ([elementName isEqualToString:@"br"]) {
        if (!_value) {
            _value = [NSMutableString new];
        }
        [_value appendString:NEWLINE];
    }
}

- (void)addChunkIfValidCharactersPending
{
    // Refactor! isNotJustWhitespace already checks for length > 0 - AWJ
    if (_value.length > 0) {
        if ([self isNotJustWhitespace:_value]) {
            [self addSubtitleChunkWithAttributes:nil text:_value];
        }
        _value = nil;
    }
}

- (void)addStyleDictionaryIfId:(NSString*)attributeName isPresentInAttributes:(NSDictionary*)attributes
{
    NSString* styleId = attributes[attributeName];
    if (styleId) {
        [_styleDictionary setValue:[self styleDictionaryFromDictionary:attributes] forKey:styleId];
    }
}

- (BOOL)isNotJustWhitespace:(NSString*)string
{
    return [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0;
}

- (void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string
{
    if (!_value) {
        _value = [NSMutableString string];
    }

    NSString* stringCleanedOfNewlines = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];

    [_value appendString:stringCleanedOfNewlines];
}

- (void)parser:(__unused NSXMLParser*)parser foundCDATA:(NSData*)CDATABlock
{
    if (!_value) {
        _value = [NSMutableString string];
    }
    [_value appendString:[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding]];
}

#pragma mark - Private

- (void)assignBaseStyleKeyFromAttributes:(NSDictionary*)attributes
{
    NSString* style = attributes[@"style"];
    if (style != nil) {
        _baseStyleKey = style;
    }
}

- (NSString*)stripXMLPrefixesFromString:(NSString*)string
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".*:" options:0 error:nil];
    return [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
}

- (NSDictionary*)stripXMLPrefixesFromStringsInDictionary:(NSDictionary*)dictionary
{
    NSMutableDictionary* newDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSString* item in dictionary) {
        NSString* newItem = [self stripXMLPrefixesFromString:item];
        [newDictionary setValue:dictionary[item] forKey:newItem];
    }
    return newDictionary;
}

@end
