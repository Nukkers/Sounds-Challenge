//
//  BBCHTTPNetworkObserver.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkObserver)
@protocol BBCHTTPNetworkObserver <NSObject>
@optional

- (void)willSendRequest:(NSURLRequest*)request;
- (void)didReceiveNetworkError:(NSError *)error NS_SWIFT_NAME(didReceiveNetworkError(_:));
- (void)didReceiveResponse:(NSHTTPURLResponse*)response;

@end

NS_ASSUME_NONNULL_END
