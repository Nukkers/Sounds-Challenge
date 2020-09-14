//
//  BBCSMPUniversalLogWriter.h
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

#import "BBCSMPDefines.h"
#import "BBCSMPLogWriter.h"

NS_CLASS_AVAILABLE_IOS(10.0)
NS_SWIFT_NAME(UniversalLog)
@interface BBCSMPUniversalLogWriter : NSObject <BBCSMPLogWriter>
BBC_SMP_INIT_UNAVAILABLE

- (instancetype)initWithDomain:(NSString *)domain subdomain:(NSString *)subdomain NS_DESIGNATED_INITIALIZER;

@end
