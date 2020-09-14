//
//  BBCHTTPOAuthRequestDecorator.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 27/10/2015.
//  Copyright © 2015 BBC. All rights reserved.
//

#import "BBCHTTPRequestDecorator.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(OAuthRequestDecorator)
@interface BBCHTTPOAuthRequestDecorator : NSObject <BBCHTTPRequestDecorator>

@property (copy, nonatomic, nullable) NSString *authenticationProvider;
@property (copy, nonatomic, nullable) NSString *accessToken;

@property (class, nonatomic, readonly) BBCHTTPOAuthRequestDecorator *OAuthRequestDecorator NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END
