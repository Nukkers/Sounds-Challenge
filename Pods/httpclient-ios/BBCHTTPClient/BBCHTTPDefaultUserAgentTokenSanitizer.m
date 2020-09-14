//
//  BBCHTTPDefaultUserAgentTokenSanitizer.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPDefaultUserAgentTokenSanitizer.h"
#import "BBCHTTPUserAgentToken.h"

@interface BBCHTTPDefaultUserAgentTokenSanitizer ()

@property (strong, nonatomic) NSCharacterSet* invalidTokenCharacters;

@end

@implementation BBCHTTPDefaultUserAgentTokenSanitizer

+ (id<BBCHTTPUserAgentTokenSanitizer>)defaultTokenSanitizer
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if ((self = [super init])) {
        NSMutableCharacterSet *validTokenCharacters = [NSMutableCharacterSet characterSetWithRange:NSMakeRange(0x21, 94)]; // vchars are 0x21 to 0x7E which corresponds to A-Z, a-z, 0-9 plus a bunch of punctuation characters (see https://tools.ietf.org/html/rfc5234#appendix-B.1)
        [validTokenCharacters removeCharactersInString:@"\"(),/:;<=>?@[\\]{}"]; // These are valid vchars but are used as delimiters in user-agent strings so not allowed in a token
        _invalidTokenCharacters = validTokenCharacters.invertedSet;
    }
    return self;
}

- (NSString *)sanitizedStringWithString:(NSString *)stringToSanitize
{
    return [[stringToSanitize componentsSeparatedByCharactersInSet:_invalidTokenCharacters] componentsJoinedByString:@""];
}

- (BBCHTTPUserAgentToken*)tokenBySanitizingToken:(BBCHTTPUserAgentToken*)token
{
    NSString *sanitizedName = [self sanitizedStringWithString:token.name];
    NSString *sanitizedVersion = [self sanitizedStringWithString:token.version];
    return [BBCHTTPUserAgentToken tokenWithName:sanitizedName version:sanitizedVersion];
}

@end
