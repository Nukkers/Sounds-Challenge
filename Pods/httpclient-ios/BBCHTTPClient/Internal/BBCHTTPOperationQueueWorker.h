//
//  BBCHTTPOperationQueueWorker.h
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/01/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCHTTPResponseWorker.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(OperationQueueWorker)
@interface BBCHTTPOperationQueueWorker : NSObject <BBCHTTPResponseWorker>

@property (nonatomic, strong) NSOperationQueue *operationQueue;

- (instancetype)initWithOperationQueue:(NSOperationQueue *)operationQueue NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
