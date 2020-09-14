//
//  BBCHTTPResponseProcessor.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 02/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ResponseProcessor)
@protocol BBCHTTPResponseProcessor <NSObject>

- (nullable id)processResponse:(id)response
                         error:(NSError * _Nullable * _Nullable)error NS_SWIFT_NAME(process(_:));

@end

NS_ASSUME_NONNULL_END
