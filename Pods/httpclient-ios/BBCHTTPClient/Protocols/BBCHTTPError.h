//
//  BBCHTTPError.h
//  BBCHTTPClient
//
//  Created by Michael Emmens on 07/09/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;

NS_SWIFT_NAME(ClientError)
@protocol BBCHTTPError <NSObject>

@property (nonatomic, readonly, nullable) NSError *error;
@property (nonatomic, readonly) NSInteger statusCode;
@property (nonatomic, readonly, nullable) NSDictionary *headers;
@property (nonatomic, readonly, nullable) id body;

@end
