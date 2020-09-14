//
//  BBCSMPLog.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(LogWriter)
@protocol BBCSMPLogWriter <NSObject>

@property (nonatomic, readonly) BOOL isDebugLoggingEnabled;

- (void)logMessage:(NSString *)message;
- (void)logDebugMessage:(NSString *)message;
- (void)logErrorMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
