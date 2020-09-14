//
//  BBCMediaConnection.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCMediaConnection.h"

@interface BBCMediaConnection ()

@property (strong,nonatomic) NSURL *href;
@property (strong,nonatomic) NSString *supplier;
@property (strong,nonatomic) NSString *transferFormat;
@property (strong,nonatomic) NSString *protocol;
@property (strong,nonatomic) NSNumber *priority;
@property (strong,nonatomic) NSNumber *dpw;
@property (strong,nonatomic) NSDate *authExpires;
@property (strong,nonatomic) NSNumber *authExpiresOffset;
@property (strong,nonatomic) NSString *server;
@property (strong,nonatomic) NSString *authString;
@property (strong,nonatomic) NSString *application;
@property (strong,nonatomic) NSString *identifier;

@property (weak,nonatomic) NSNumberFormatter *numberFormatter;
@property (weak,nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation BBCMediaConnection

- (instancetype)init
{
    return [self initWithDictionary:@{} numberFormatter:[NSNumberFormatter new] dateFormatter:[NSDateFormatter new]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary numberFormatter:(NSNumberFormatter *)numberFormatter dateFormatter:(NSDateFormatter *)dateFormatter
{
    if ((self = [super init])) {
        self.numberFormatter = numberFormatter;
        self.dateFormatter = dateFormatter;
        [self setValuesForKeysWithDictionary:dictionary];
        self.numberFormatter = nil;
        self.dateFormatter = nil;
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"dpw"] && [value isKindOfClass:[NSString class]]) {
        self.dpw = [_numberFormatter numberFromString:value];
    } else if ([key isEqualToString:@"priority"] && [value isKindOfClass:[NSString class]]) {
        self.priority = [_numberFormatter numberFromString:value];
    } else if ([key isEqualToString:@"href"] && [value isKindOfClass:[NSString class]]) {
        self.href = [NSURL URLWithString:value];
    }  else if ([key isEqualToString:@"authExpires"] && [value isKindOfClass:[NSString class]]) {
        self.authExpires = [_dateFormatter dateFromString:[value stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([value length]-5,5)]];
    }  else if ([key isEqualToString:@"authExpiresOffset"] && [value isKindOfClass:[NSString class]]) {
        self.authExpiresOffset = [_numberFormatter numberFromString:value];
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"BBCMediaConnection: Undefined key - %@ : %@",key,value);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n    Supplier:%@; Transfer-format:%@; Protocol:%@; Priority:%@; DPW:%@; URL:%@\n",[super description],_supplier,_transferFormat,_protocol,_priority,_dpw,[_href absoluteString]];
}

@end
