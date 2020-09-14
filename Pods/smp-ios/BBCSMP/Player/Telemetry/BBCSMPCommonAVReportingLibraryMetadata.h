//
//  BBCSMPCommonAVReportingLibraryMetadata.h
//  SMP
//
//  Created by Andrew Wilson-Jones on 18/03/2020.
//  Copyright © 2020 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(CommonAVReportingLibraryMetadata)
@interface BBCSMPCommonAVReportingLibraryMetadata : NSObject

@property (nonatomic, readonly) NSString *libraryName;
@property (nonatomic, readonly) NSString *libraryVersion;

-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithLibraryName:(NSString *)libraryName andVersion:(NSString *)libraryVersion;

@end

NS_ASSUME_NONNULL_END
