//
//  BBCHTTPSAMLRequestDecorator.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 27/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPRequestDecorator.h"
#import "HTTPClientDefines.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(SAMLRequestDecorator)
@interface BBCHTTPSAMLRequestDecorator : NSObject <BBCHTTPRequestDecorator>
HTTP_CLIENT_INIT_UNAVAILABLE

@property (copy, nonatomic) NSString *samlToken;

+ (instancetype)SAMLRequestDecoratorWithClientName:(NSString *)clientName;
- (instancetype)initWithClientName:(NSString *)clientName NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
