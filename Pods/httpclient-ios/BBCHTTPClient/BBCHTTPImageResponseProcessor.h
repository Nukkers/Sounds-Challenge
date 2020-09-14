//
//  BBCHTTPImageResponseProcessor.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 27/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPResponseProcessor.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ImageResponseProcessor)
@interface BBCHTTPImageResponseProcessor : NSObject <BBCHTTPResponseProcessor>

@property (class, nonatomic, readonly) BBCHTTPImageResponseProcessor *ImageResponseProcessor NS_SWIFT_UNAVAILABLE("Access this property using `processor` instead");

@end

NS_ASSUME_NONNULL_END
