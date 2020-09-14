//
//  BBCSMPCommonAVReportingLibraryMetadata.m
//  SMP
//
//  Created by Andrew Wilson-Jones on 18/03/2020.
//  Copyright © 2020 BBC. All rights reserved.
//

#import "BBCSMPCommonAVReportingLibraryMetadata.h"

@implementation BBCSMPCommonAVReportingLibraryMetadata

-(instancetype)initWithLibraryName:(NSString *)libraryName andVersion:(nonnull NSString *)libraryVersion {
    self = [super init];

    if (self) {
        _libraryName = libraryName;
        _libraryVersion = libraryVersion;
    }

    return self;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[BBCSMPCommonAVReportingLibraryMetadata class]]) {
        return NO;
    }

    BBCSMPCommonAVReportingLibraryMetadata* castedLibraryMetadata = (BBCSMPCommonAVReportingLibraryMetadata*)object;



    return castedLibraryMetadata.libraryName==self.libraryName && castedLibraryMetadata.libraryVersion==self.libraryVersion;
}

@end
