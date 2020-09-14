//
//  BBCMediaConnection.h
//  BBCMediaSelectorClient
//
//  Created by Michael Emmens on 04/02/2015.
//  Copyright (c) 2015 BBC. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(MediaConnection)
@interface BBCMediaConnection : NSObject

@property (nonatomic, readonly, nullable) NSURL *href;
@property (nonatomic, readonly, nullable) NSString *supplier;
@property (nonatomic, readonly, nullable) NSString *transferFormat;
@property (nonatomic, readonly, nullable) NSString *protocol;
@property (nonatomic, readonly, nullable) NSNumber *priority;
@property (nonatomic, readonly, nullable) NSNumber *dpw;
@property (nonatomic, readonly, nullable) NSDate *authExpires;
@property (nonatomic, readonly, nullable) NSNumber *authExpiresOffset;
@property (nonatomic, readonly, nullable) NSString *server;
@property (nonatomic, readonly, nullable) NSString *authString;
@property (nonatomic, readonly, nullable) NSString *application NS_SWIFT_NAME(applicationName);
@property (nonatomic, readonly, nullable) NSString *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                   numberFormatter:(NSNumberFormatter *)numberFormatter
                     dateFormatter:(NSDateFormatter *)dateFormatter NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
