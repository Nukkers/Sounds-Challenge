//
//  BBCHTTPJSONResponseProcessor.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 02/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPResponseProcessor.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(JSONResponseProcessor)
@interface BBCHTTPJSONResponseProcessor : NSObject <BBCHTTPResponseProcessor>

@property (class, nonatomic, readonly) BBCHTTPJSONResponseProcessor *JSONResponseProcessor NS_SWIFT_UNAVAILABLE("Access this property using `processor` instead");

@end

NS_ASSUME_NONNULL_END
