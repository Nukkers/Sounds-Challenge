//
//  BBCHTTPImageResponseProcessor-iOS.m
//  BBCHTTPClient
//
//  Created by Timothy James Condon on 03/08/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPImageResponseProcessor.h"
@import UIKit;

@interface BBCHTTPImageResponseProcessor()

@property (nonatomic) CGFloat scale;

@end

#pragma mark -

@implementation BBCHTTPImageResponseProcessor

static NSString* BBCHTTPJSONResponseProcessorErrorDomain = @"BBCHTTPImageResponseProcessor";

+ (BBCHTTPImageResponseProcessor*)ImageResponseProcessor
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if ((self = [super init])) {
        _scale = [UIScreen mainScreen].scale;
    }

    return self;
}

- (id)processResponse:(id)response error:(NSError**)error
{
    if ([response isKindOfClass:[NSData class]]) {
        NSData* responseData = response;
        UIImage* image = [UIImage imageWithData:responseData scale:_scale];
        return image;
    }
    else {
        return nil;
    }
}

@end
