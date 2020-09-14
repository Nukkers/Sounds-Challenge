//
//  BBCHTTPStringUserAgent.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCHTTPStringUserAgent.h"

@interface BBCHTTPStringUserAgent ()

@property (strong,nonatomic) NSString *userAgent;

@end

#pragma mark -

@implementation BBCHTTPStringUserAgent

+ (BBCHTTPStringUserAgent *)userAgentWithString:(NSString *)userAgentString
{
    return [[self alloc] initWithString:userAgentString];
}

- (instancetype)initWithString:(NSString *)userAgentString
{
    if ((self = [super init])) {
        _userAgent = userAgentString;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object conformsToProtocol:@protocol(BBCHTTPUserAgent)]) {
        return NO;
    }
    
    id<BBCHTTPUserAgent> otherUserAgent = object;
    if (!otherUserAgent.userAgent && self.userAgent) {
        return NO;
    }
    
    return [_userAgent isEqualToString:otherUserAgent.userAgent];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <userAgent=\"%@\">",super.description, _userAgent];
}

@end
