//
//  BBCHTTPNetworkClientAuthenticationDelegate.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 04/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(NetworkClientAuthenticationDelegate)
@protocol BBCHTTPNetworkClientAuthenticationDelegate <NSObject>

- (void)handleChallenge:(NSURLAuthenticationChallenge *)challenge
      completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;

@end

NS_ASSUME_NONNULL_END
