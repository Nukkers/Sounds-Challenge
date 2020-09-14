//
//  BBCSMPSubtitleParserResult.h
//  BBCSMP
//
//  Created by Michael Emmens on 09/12/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

@class BBCSMPSubtitle;

@interface BBCSMPSubtitleParserResult : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, strong, readonly) NSDictionary* styleDictionary;
@property (nonatomic, strong, readonly) NSArray<BBCSMPSubtitle*>* subtitles;
@property (nonatomic, strong, readonly) NSString* baseStyleKey;

- (instancetype)initWithStyleDictionary:(NSDictionary*)styleDictionary
                              subtitles:(NSArray<BBCSMPSubtitle*>*)subtitles
                           baseStyleKey:(NSString*)baseStyleKey NS_DESIGNATED_INITIALIZER;

@end
