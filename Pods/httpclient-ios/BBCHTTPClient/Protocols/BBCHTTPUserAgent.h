//
//  BBCHTTPUserAgent.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 14/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;

NS_SWIFT_NAME(UserAgent)
@protocol BBCHTTPUserAgent <NSObject>

@property (nonatomic, readonly, nonnull) NSString *userAgent;

@end
