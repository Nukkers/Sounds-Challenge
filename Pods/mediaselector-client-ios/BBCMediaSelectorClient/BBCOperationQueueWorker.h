//
//  BBCOperationQueueWorker.h
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/05/2016.
//  Copyright © 2016 Michael Emmens. All rights reserved.
//

#import "BBCWorker.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(OperationQueueWorker)
@interface BBCOperationQueueWorker : NSObject <BBCWorker>

- (instancetype)initWithOperationQueue:(NSOperationQueue*)operationQueue NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
