//
//  BBCHTTPLogger.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 25/02/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Logger)
@protocol BBCHTTPLogger <NSObject>

- (void)logString:(NSString*)string NS_SWIFT_NAME(log(string:));

@end

NS_ASSUME_NONNULL_END
