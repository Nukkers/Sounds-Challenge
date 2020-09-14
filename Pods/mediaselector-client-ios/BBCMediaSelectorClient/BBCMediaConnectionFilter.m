//
//  BBCMediaConnectionFilter.m
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 28/09/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCMediaConnectionFilter.h"

@interface BBCMediaConnectionFilter ()

@property (strong,nonatomic) NSMutableDictionary<NSString*, NSSet*>* filters;

@end

@implementation BBCMediaConnectionFilter

+ (BBCMediaConnectionFilter *)filter
{
    return [[BBCMediaConnectionFilter alloc] init];
}

+ (BBCMediaConnectionFilter *)filterWithFilter:(BBCMediaConnectionFilter *)filter
{
    return [[BBCMediaConnectionFilter alloc] initWithFilter:filter];
}

- (instancetype)init
{
    if ((self = [super init])) {
        _filters = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithFilter:(BBCMediaConnectionFilter*)filter
{
    if ((self = [super init])) {
        _filters = [filter.filters mutableCopy];
    }
    return self;
}

- (instancetype)withRequiredTransferFormats:(NSArray *)requiredTransferFormats
{
    [_filters setValue:requiredTransferFormats?[NSSet setWithArray:requiredTransferFormats]:nil forKey:@"transferFormat"];
    return self;
}

- (instancetype)withRequiredProtocols:(NSArray *)requiredProtocols
{
    [_filters setValue:requiredProtocols?[NSSet setWithArray:requiredProtocols]:nil forKey:@"protocol"];
    return self;
}

- (instancetype)withRequiredSuppliers:(NSArray *)requiredSuppliers
{
    [_filters setValue:requiredSuppliers?[NSSet setWithArray:requiredSuppliers]:nil forKey:@"supplier"];
    return self;
}

- (NSDictionary<NSString*, NSSet*>*)requiredFilters
{
    return [NSDictionary dictionaryWithDictionary:_filters];
}

@end
