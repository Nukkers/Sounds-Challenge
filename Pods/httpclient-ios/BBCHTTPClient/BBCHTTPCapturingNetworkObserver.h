//
//  BBCHTTPCapturingNetworkObserver.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

#import "BBCHTTPNetworkObserver.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(CapturingNetworkObserver)
@interface BBCHTTPCapturingNetworkObserver : NSObject <BBCHTTPNetworkObserver>

@property (nonatomic, readonly) NSArray<NSURLRequest*>* requests;
@property (nonatomic, readonly) NSArray<NSError*>* errors;
@property (nonatomic, readonly) NSArray<NSHTTPURLResponse*>*responses;

@property (nonatomic, nullable, readonly) NSURLRequest* lastRequest;
@property (nonatomic, nullable, readonly) NSError *lastError;
@property (nonatomic, nullable, readonly) NSHTTPURLResponse *lastResponse;

- (void)clearRequests;
- (void)clearErrors;
- (void)clearResponses;

- (void)clearAll;

@end

NS_ASSUME_NONNULL_END
