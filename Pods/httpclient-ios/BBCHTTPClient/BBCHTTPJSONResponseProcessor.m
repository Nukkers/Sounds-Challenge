//
//  BBCHTTPJSONResponseProcessor.m
//  BBCHTTPClient
//
//  Created by Michael Emmens on 02/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPJSONResponseProcessor.h"
@import Foundation;

@implementation BBCHTTPJSONResponseProcessor

+ (BBCHTTPJSONResponseProcessor *)JSONResponseProcessor
{
    return [[self alloc] init];
}

- (id)processResponse:(id)response error:(NSError **)error
{
    if ([response isKindOfClass:[NSData class]]) {
        NSData *responseData = response;
        NSError *jsonError = nil;
        id jsonObject = nil;
        if (responseData.length > 0) {
            jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
        }
        if (!jsonObject && error) {
            *error = jsonError;
        }
        return jsonObject;
    }
    else {
        return nil;
    }
}

@end
