//
//  BBCSMPKVOReceptionist.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBCSMPWorker;

@interface BBCSMPKVOReceptionist : NSObject
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)receptionistWithSubject:(NSObject*)subject
                                keyPath:(NSString*)keyPath
                                options:(NSKeyValueObservingOptions)options
                                context:(void*)context
                         callbackWorker:(id<BBCSMPWorker>)worker
                                 target:(id)target
                               selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
