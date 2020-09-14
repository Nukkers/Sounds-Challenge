//
//  BBCNSInvocationLogMessage.h
//  SMP
//
//  Created by Thomas Sherwood on 09/02/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

#import <SMP/SMP-Swift.h>

@interface BBCNSInvocationLogMessage : NSObject <BBCLogMessage>
BBC_SMP_INIT_UNAVAILABLE

+ (instancetype)messageWithInvocation:(NSInvocation *)invocation;

@end
