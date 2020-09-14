//
//  BBCSMPTelemetryLastRequestedItemTracker.h
//  Pods
//
//  Created by Ryan Johnstone on 29/06/2017.
//
//

#import "BBCSMPAVType.h"
#import "BBCSMPDefines.h"
#import "BBCSMPStreamType.h"

@class BBCSMPEventBus;

@interface BBCSMPTelemetryLastRequestedItemTracker : NSObject
BBC_SMP_INIT_UNAVAILABLE

@property (nonatomic, readonly) NSString *vpidForCurrentItem;
@property (nonatomic, readonly) BBCSMPAVType avType;
@property (nonatomic, readonly) BBCSMPStreamType streamType;
@property (nonatomic, readonly) NSString *supplier;
@property (nonatomic, readonly) NSString *transferFormat;
@property (nonatomic, readonly) NSString *libraryName;
@property (nonatomic, readonly) NSString *libraryVersion;

- (instancetype)initWithEventBus:(BBCSMPEventBus *)eventBus;

@end
