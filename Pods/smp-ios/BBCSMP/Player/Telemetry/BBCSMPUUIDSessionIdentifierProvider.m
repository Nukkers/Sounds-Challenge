//
//  BBCSMPUUIDSessionIdentifierProvider.m
//  BBCSMP
//
//  Created by Ryan Johnstone on 21/06/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPUUIDSessionIdentifierProvider.h"

@interface BBCSMPUUIDSessionIdentifierProvider()

@property (nonatomic, strong) NSString* uuid;

@end

@implementation BBCSMPUUIDSessionIdentifierProvider

-(instancetype)init
{
    self = [super init];
    if (self) {
        _uuid = [BBCSMPUUIDSessionIdentifierProvider generateNewUUID];
    }
    return self;
}

-(NSString *)getSessionIdentifier
{
    return _uuid;
}

- (void)newSessionStarted {
    _uuid = [BBCSMPUUIDSessionIdentifierProvider generateNewUUID];
}

+ (NSString *)generateNewUUID {
    return [[NSUUID UUID] UUIDString];
}

@end
