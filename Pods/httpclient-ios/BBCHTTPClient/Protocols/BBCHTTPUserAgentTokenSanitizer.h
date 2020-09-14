//
//  BBCHTTPUserAgentTokenSanitizer.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 15/01/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@class BBCHTTPUserAgentToken;

NS_SWIFT_NAME(UserAgentTokenSanitizer)
@protocol BBCHTTPUserAgentTokenSanitizer <NSObject>

- (BBCHTTPUserAgentToken*)tokenBySanitizingToken:(BBCHTTPUserAgentToken*)token NS_SWIFT_NAME(token(bySanitizing:));

@end

NS_ASSUME_NONNULL_END
