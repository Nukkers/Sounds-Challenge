//
//  BBCSMPError.m
//  BBCMediaPlayer
//
//  Created by Michael Emmens on 29/05/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

#import "BBCSMPError.h"

NSString* const BBCSMPPlayerErrorDomain = @"BBCSMPPlayerErrorDomain";

NSString* NSStringFromBBCSMPErrorEnumeration(BBCSMPErrorEnumeration error)
{
    switch (error) {
    case BBCSMPErrorUnknown:
        return @"Unknown";

    case BBCSMPErrorFailedToPlayToEnd:
        return @"Failed To Play To End";

    case BBCSMPErrorInitialLoadFailed:
        return @"Initial Load Failed";

    case BBCSMPErrorAvailableCDNsExceeded:
        return @"Available CDNs Exceeded";

    case BBCSMPErrorMediaResolutionFailed:
        return @"Media Resolution Failed";
    }
}

#pragma mark -

@interface BBCSMPError ()

@property (nonatomic, strong) NSError* error;
@property (nonatomic, assign) BOOL recoverable;

@end

@implementation BBCSMPError

+ (instancetype)error:(NSError*)error
{
    return [[BBCSMPError alloc] initWithError:error andReason:BBCSMPErrorUnknown];
}

+ (instancetype)error:(NSError*)error andReason:(BBCSMPErrorEnumeration)reason
{
    return [[BBCSMPError alloc] initWithError:error andReason:reason];
}

+ (instancetype)recoverableError:(NSError*)error
{
    BBCSMPError* recoverableError = [[BBCSMPError alloc] initWithError:error andReason:BBCSMPErrorUnknown];
    recoverableError.recoverable = YES;
    return recoverableError;
}

- (instancetype)initWithError:(NSError*)error andReason:(BBCSMPErrorEnumeration)reason
{
    NSError *underlyingError = error ? error : [NSError errorWithDomain:@"smp-ios" code:1 userInfo:@{ NSLocalizedDescriptionKey : @"An unknown error occurred" }];
    return self = [self initWithError:underlyingError reason:reason recoverable:NO];
}

- (instancetype)initWithError:(NSError *)error reason:(BBCSMPErrorEnumeration)reason recoverable:(BOOL)recoverable
{
    self = [super init];
    if (self) {
        _error = error;
        _reason = reason;
        _recoverable = recoverable;
    }
    
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ : %@ : %@", [super description], _recoverable ? @"Recoverable" : @"Unrecoverable", [_error description]];
}

- (BOOL)isEqual:(id)object
{
    BBCSMPError *other = (BBCSMPError *)object;
    if (![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [_error isEqual:other.error] &&
           _reason == other.reason &&
           _recoverable == other.recoverable &&
           _recovered == other.recovered;
}

@end
