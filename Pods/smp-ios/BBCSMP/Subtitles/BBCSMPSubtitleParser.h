//
//  BBCSMPSubtitleParser.h
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 03/06/2015.
//  Copyright 2015 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBCSMPSubtitleParserResult;

@interface BBCSMPSubtitleParser : NSObject

- (BBCSMPSubtitleParserResult*)parse:(NSData*)utf8EncodedXMLData;

@end
