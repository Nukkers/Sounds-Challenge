//
//  BBCSMPSubtitleRegion.m
//  BBCSMP
//
//  Created by Al Priest on 15/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPSubtitleRegion.h"

typedef struct {
    CGPoint point;
    BOOL isValid;
} CGValidPoint;

@implementation BBCSMPSubtitleRegion

- (instancetype)initWithAttributes:(NSDictionary*)attributes
{
    if (self = [super init]) {
        _regionId = [attributes objectForKey:@"id"];
        _displayAlign = [attributes objectForKey:@"displayAlign"];
        NSString* originString = [attributes objectForKey:@"origin"];
        NSString* extentString = [attributes objectForKey:@"extent"];
        
        CGValidPoint originPoint = [self parsePointFromString:originString];
        if (!originPoint.isValid){
            return nil;
        }
        _origin = originPoint.point;
        
        if (extentString != nil){
            CGValidPoint extentPoint = [self parsePointFromString:extentString];
            if (!extentPoint.isValid){
                return nil;
            }
            _extent = extentPoint.point;
        }
    }
    return self;
}

- (BOOL)hasPositionalSubtitles
{
    return true;
}

- (CGValidPoint)parsePointFromString:(NSString*) inputString
{
    CGValidPoint point;
    point.isValid = false;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^([\\d\\.]+)% ([\\d\\.]+)%$" options:0 error:nil];
    NSArray<NSTextCheckingResult*>* matches = [regex matchesInString:inputString options:0 range:NSMakeRange(0, [inputString length])];
    
    if ([matches count] != 0) {
        NSTextCheckingResult* match = [matches objectAtIndex:0];
        CGFloat x = [[inputString substringWithRange:[match rangeAtIndex:1]] floatValue];
        CGFloat y = [[inputString substringWithRange:[match rangeAtIndex:2]] floatValue];
        point.point = CGPointMake(x, y);
        point.isValid = true;
    }
    return point;
}
@end
