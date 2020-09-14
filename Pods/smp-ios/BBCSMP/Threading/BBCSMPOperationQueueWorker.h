//
//  BBCSMPOperationQueueWorker.h
//  BBCSMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/07/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCSMPWorker.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBCSMPOperationQueueWorker : NSObject <BBCSMPWorker>

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
